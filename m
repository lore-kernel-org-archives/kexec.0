Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-yk0-x244.google.com ([2607:f8b0:4002:c07::244])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1aMIR9-0005Pd-0R
 for kexec@lists.infradead.org; Thu, 21 Jan 2016 16:50:20 +0000
Received: by mail-yk0-x244.google.com with SMTP id k129so3858060yke.3
 for <kexec@lists.infradead.org>; Thu, 21 Jan 2016 08:49:58 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1453377959.9549.84.camel@linux.vnet.ibm.com>
References: <1453129886-20192-1-git-send-email-zohar@linux.vnet.ibm.com>
 <1453129886-20192-8-git-send-email-zohar@linux.vnet.ibm.com>
 <20160120233919.GM11277@wotan.suse.de>
 <CAB=NE6Wbx4hY6q2skNp4JQVvfP-eCHxr3rT3h1bq6zuSsoN9+w@mail.gmail.com>
 <1453377959.9549.84.camel@linux.vnet.ibm.com>
From: "Luis R. Rodriguez" <mcgrof@suse.com>
Date: Thu, 21 Jan 2016 08:49:38 -0800
Message-ID: <CAB=NE6X7ykN2f3YctOuPRO=BGaV1J4j0yHe75RdbYQAeQJgsAQ@mail.gmail.com>
Subject: Re: [RFC PATCH v2 07/11] firmware: replace call to
 fw_read_file_contents() with kernel version
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
Cc: Kees Cook <keescook@chromium.org>, fsdevel@vger.kernel.org, Dmitry Kasatkin <dmitry.kasatkin@gmail.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, kexec@lists.infradead.org, David Howells <dhowells@redhat.com>, linux-security-module <linux-security-module@vger.kernel.org>, Johannes Berg <johannes@sipsolutions.net>, David Woodhouse <dwmw2@infradead.org>, linux-modules@vger.kernel.org

On Thu, Jan 21, 2016 at 4:05 AM, Mimi Zohar <zohar@linux.vnet.ibm.com> wrote:
> On Wed, 2016-01-20 at 15:56 -0800, Luis R. Rodriguez wrote:
>> On Wed, Jan 20, 2016 at 3:39 PM, Luis R. Rodriguez <mcgrof@suse.com> wrote:
>
>> >> @@ -350,13 +321,18 @@ static int fw_get_filesystem_firmware(struct device *device,
>> >>               file = filp_open(path, O_RDONLY, 0);
>> >>               if (IS_ERR(file))
>> >>                       continue;
>> >> -             rc = fw_read_file_contents(file, buf);
>> >> +
>> >> +             buf->size = 0;
>> >> +             rc = kernel_read_file(file, &buf->data, &size, INT_MAX,
>> >> +                                   FIRMWARE_CHECK);
>> >
>> > The way kernel firmware signing was implemented was that we'd first read the
>> > foo.sig (or whatever extension we use).
>
> Was there a reason for using a detached signature and not using the same
> method as kernel modules?

Yes, the firmware might have different license. Its also easier for
users to use standard mechanisms to verify.

>> The same kernel_read_file() would be
>> > used if this gets applied so this would still works well with that. Of course
>> > folks using IMA and their own security policy would just disable the kernel
>> > fw signing facility.
>
> Right, support for not measuring/appraising the firmware and sig would
> be supported in the policy.

OK!

>> >> diff --git a/include/linux/ima.h b/include/linux/ima.h
>> >> index ae91938..0a7f039 100644
>> >> --- a/include/linux/ima.h
>> >> +++ b/include/linux/ima.h
>> >> @@ -16,6 +16,7 @@ struct linux_binprm;
>> >>  enum ima_policy_id {
>> >>       KEXEC_CHECK = 1,
>> >>       INITRAMFS_CHECK,
>> >> +     FIRMWARE_CHECK,
>> >>       IMA_MAX_READ_CHECK
>> >>  };
>> >
>> > The only thing that is worth questioning here in light of kernel fw signing is
>> > what int policy_id do we use? Would we be OK to add FIRMWARE_SIG_CHECK later
>> > While at it, perhaps kernel_read_file() last argument should be enum
>> > ima_policy_id then. If the policy_id is going to be used elsewhere outside of
>> > IMA then perhaps ima.h is not the best place for it ? Would fs.h for type of
>> > file be OK ? Then we'd have a list of known file types the kernel reads.
>
> I would definitely prefer the enumeration be defined at the VFS layer.
> For example,
>
> enum kernel_read_file_id {
>         READING_KEXEC_IMAGE,
>         READING_KEXEC_INITRAMFS,
>         READING_FIRMWARE,
>         READING_FIRMWARE_SIG,
>         READING_MAX_ID
> };

Looks good to me. Please add a kdoc section to force us to have to
document each one.

> Agreed, the last field of kernel_read_file() and the wrappers should be
> the enumeration.

Great.

>> Actually your patch #9 "ima: load policy using path" defines
>> kernel_read_file_from_path and since the firmware code uses a path
>> this code would be much cleaner if instead you used that. It'd mean
>> more code sharing and would make firmware code cleaner. Could you
>> re-order that to go first and then later this as its first user?
>> Perhaps add the helper for the firmware patch.
>
> Thanks, I missed that.  I'll include this change in the next version.

Great.

  Luis

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
