Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-ig0-x234.google.com ([2607:f8b0:4001:c05::234])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1aMNG4-0004sG-1R
 for kexec@lists.infradead.org; Thu, 21 Jan 2016 21:59:12 +0000
Received: by mail-ig0-x234.google.com with SMTP id z14so136038820igp.1
 for <kexec@lists.infradead.org>; Thu, 21 Jan 2016 13:58:51 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1453410902.9549.184.camel@linux.vnet.ibm.com>
References: <1453129886-20192-1-git-send-email-zohar@linux.vnet.ibm.com>
 <20160121000300.GN11277@wotan.suse.de>
 <1453381932.9549.131.camel@linux.vnet.ibm.com>
 <5369666.tSqfcRVJfN@sifl>
 <1453410902.9549.184.camel@linux.vnet.ibm.com>
Date: Thu, 21 Jan 2016 13:58:50 -0800
Message-ID: <CAGXu5jJe9PzBR2o7wLJ7hD_X-X9_zKZUzaZmy1oyprcjCXyq6w@mail.gmail.com>
Subject: Re: [RFC PATCH v2 08/11] module: replace copy_module_from_fd with
 kernel version
From: Kees Cook <keescook@chromium.org>
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
To: Mimi Zohar <zohar@linux.vnet.ibm.com>
Cc: David Howells <dhowells@redhat.com>, John Johansen <john.johansen@canonical.com>, "linux-fsdevel@vger.kernel.org" <fsdevel@vger.kernel.org>, Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>, Dmitry Kasatkin <dmitry.kasatkin@gmail.com>, "Luis R. Rodriguez" <mcgrof@suse.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Kexec Mailing List <kexec@lists.infradead.org>, Paul Moore <pmoore@redhat.com>, linux-security-module <linux-security-module@vger.kernel.org>, Casey Schaufler <casey@schaufler-ca.com>, David Woodhouse <dwmw2@infradead.org>, linux-modules@vger.kernel.org

On Thu, Jan 21, 2016 at 1:15 PM, Mimi Zohar <zohar@linux.vnet.ibm.com> wrote:
> On Thu, 2016-01-21 at 10:45 -0500, Paul Moore wrote:
>> On Thursday, January 21, 2016 08:12:12 AM Mimi Zohar wrote:
>> > Paul, Casey, Kees, Jon, Tetsuo does it make sense to consolidate the
>> > module, firmware, and kexec pre and post security hooks and have just
>> > one set of pre and post security kernel_read_file hook instead?   Does
>> > it make sense for this patch set to define the new hooks to allow the
>> > LSMs to migrate to it independently of each other?
>>
>> Well, as usual, the easiest way to both get solid feedback and actually get a
>> change accepted is to post patches to the affected LSMs.  Probably not what
>> you wanted to hear, but at least I'm honest :)
>
> Unless I'm misreading the code, it might be a lot simpler than I
> thought.  Of the three LSM hooks kernel_module_request,
> kernel_module_from_file, and kernel_fw_from_file, the only upstreamed
> LSM on any of these hooks is SELinux, which is only on the
> kernel_module_request hook.
>
> After converting the SELinux kernel_module_request hook to use the new
> kernel_read_file(),  do I then remove the three hooks?   Are we
> concerned about "minor" LSMs that have not been upstreamed that might be
> using these hooks?

It should be easy for me to port my LSM to use the new hook. No
objections in consolidating things.

(Which reminds me to resend my LSM again...)

-Kees

-- 
Kees Cook
Chrome OS & Brillo Security

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
