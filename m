Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-yk0-x241.google.com ([2607:f8b0:4002:c07::241])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1aMIY8-0002Kh-Aj
 for kexec@lists.infradead.org; Thu, 21 Jan 2016 16:57:33 +0000
Received: by mail-yk0-x241.google.com with SMTP id a85so3867927ykb.2
 for <kexec@lists.infradead.org>; Thu, 21 Jan 2016 08:57:11 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1453381932.9549.131.camel@linux.vnet.ibm.com>
References: <1453129886-20192-1-git-send-email-zohar@linux.vnet.ibm.com>
 <1453129886-20192-9-git-send-email-zohar@linux.vnet.ibm.com>
 <20160121000300.GN11277@wotan.suse.de>
 <1453381932.9549.131.camel@linux.vnet.ibm.com>
From: "Luis R. Rodriguez" <mcgrof@suse.com>
Date: Thu, 21 Jan 2016 08:56:51 -0800
Message-ID: <CAB=NE6VS1xptdnmfPLC4fGmFwdBSjAHxcmK9ThLP4haHa_j6fA@mail.gmail.com>
Subject: Re: [RFC PATCH v2 08/11] module: replace copy_module_from_fd with
 kernel version
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Mimi Zohar <zohar@linux.vnet.ibm.com>, Joey Lee <jlee@suse.com>, Gary Lin <GLin@suse.com>
Cc: David Howells <dhowells@redhat.com>, John Johansen <john.johansen@canonical.com>, Kees Cook <keescook@chromium.org>, fsdevel@vger.kernel.org, Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>, Dmitry Kasatkin <dmitry.kasatkin@gmail.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, kexec@lists.infradead.org, Paul Moore <pmoore@redhat.com>, linux-security-module <linux-security-module@vger.kernel.org>, Casey Schaufler <casey@schaufler-ca.com>, David Woodhouse <dwmw2@infradead.org>, linux-modules@vger.kernel.org

On Thu, Jan 21, 2016 at 5:12 AM, Mimi Zohar <zohar@linux.vnet.ibm.com> wrote:
> On Thu, 2016-01-21 at 01:03 +0100, Luis R. Rodriguez wrote:
>> On Mon, Jan 18, 2016 at 10:11:23AM -0500, Mimi Zohar wrote:
>> > This patch replaces the module copy_module_from_fd() call with the VFS
>> > common kernel_read_file_from_fd() function.  Instead of reading the
>> > kernel module twice, once for measuring/appraising and then loading
>> > the kernel module, the file is read once.
>> >
>> > This patch defines a new security hook named security_kernel_read_file(),
>> > which is called before reading the file.  For now, call the module
>> > security hook from security_kernel_read_file until the LSMs have been
>> > converted to use the kernel_read_file hook.
>> >
>> > This patch retains the kernel_module_from_file hook, but removes the
>> > security_kernel_module_from_file() function.
>>
>> I think it would help if your cover letter and this patch described
>> a bit that some LSMs either prefer to read / check / appraise files
>> prior to loading and some other prefer to do that later. You could
>> explain the LSM hook preferences and what they do. Then here you
>> can explain how this one prefers a hook early, but acknowledge that
>> the other one still exists.
>
> Before this patch set, IMA measured/appraised/audited a file before
> allowing it to be accessed, causing the file in some cases to be read
> twice.   This patch set changes that.  Files are read into memory and
> then measured/appraised/audited.

Sounds like this could help also with performance, has any preliminary
benchmarking been done to see the effect ?

> It's been a while since this hook was added.  As I recall, Kees added
> the pre module hook to limit loading kernel modules to only those
> filesystems that were mounted read-only.  I would have to look at each
> of the LSMs to see how they're using the hooks.

Sure.

>> So:
>>
>> kernel_read_file() {
>>       ...
>>       security_kernel_read_file();
>>       ...
>>       security_kernel_post_read_file();
>>       ...
>> }
>>
>> > diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
>> > index 4e6e2af..9915310 100644
>> > --- a/include/linux/lsm_hooks.h
>> > +++ b/include/linux/lsm_hooks.h
>> > @@ -1465,6 +1471,7 @@ union security_list_options {
>> >     int (*kernel_fw_from_file)(struct file *file, char *buf, size_t size);
>> >     int (*kernel_module_request)(char *kmod_name);
>> >     int (*kernel_module_from_file)(struct file *file);
>> > +   int (*kernel_read_file)(struct file *file, int policy_id);
>> >     int (*kernel_post_read_file)(struct file *file, char *buf, loff_t size,
>> >                                  int policy_id);
>> >     int (*task_fix_setuid)(struct cred *new, const struct cred *old,
>>
>> Is the goal to eventually kill the other LSM hooks and just keep the
>> file one? If so where is that done in this series? It was not clear.
>
> As mentioned in the cover letter, consolidating the LSM hooks is not
> covered in this patch set.

Sorry I missed that after I started reviewing.

> I was under the impression that not only
> were we defining a common kernel read file function, but that we were
> also consolidating the pre and post security hooks as well.

Sure.

> By defining
> the pre and post security hooks in this patch set, it permits each of
> the LSMs to migrate to the new hooks independently of each other.   Lets
> ask the LSM maintainers what they think.

I see -- yeah making this a 2 step thing makes sense, so long as the
maintainers can later expect / understand what would be done in a
second patch set. Breaking this down in two patch sets makes sense. It
should also mean there might be fun benchmarks on gains provided there
were considerable IO savings by not opening files twice.


  Luis

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
