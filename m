Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-ia0-x231.google.com ([2607:f8b0:4001:c02::231])
 by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1U0fq3-0001ME-CI
 for kexec@lists.infradead.org; Wed, 30 Jan 2013 22:09:04 +0000
Received: by mail-ia0-f177.google.com with SMTP id h8so2973670iaa.8
 for <kexec@lists.infradead.org>; Wed, 30 Jan 2013 14:09:02 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <510991F3.9020006@zytor.com>
References: <1359581120-24397-1-git-send-email-yinghai@kernel.org>
 <1359581120-24397-4-git-send-email-yinghai@kernel.org>
 <510991F3.9020006@zytor.com>
Date: Wed, 30 Jan 2013 14:09:02 -0800
Message-ID: <CAE9FiQXaTkgmJbQ_6ZacwPx=2v+8XV0HBChtx+pE0agc=QkAjg@mail.gmail.com>
Subject: Re: [PATCH v8 3/7] kexec,
 x86: clean boot_params area for entry-32bit path
From: Yinghai Lu <yinghai@kernel.org>
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
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: Simon Horman <horms@verge.net.au>, kexec@lists.infradead.org, "Eric W. Biederman" <ebiederm@xmission.com>, Vivek Goyal <vgoyal@redhat.com>

On Wed, Jan 30, 2013 at 1:34 PM, H. Peter Anvin <hpa@zytor.com> wrote:
> On 01/30/2013 01:25 PM, Yinghai Lu wrote:
>>
>> +static void clean_boot_params(unsigned char *real_mode, unsigned long size)
>> +{
>> +     unsigned long end;
>> +
>> +     /* clear value before header */
>> +     memset(real_mode, 0, 0x1f1);
>> +     /* clear value after setup_header  */
>> +     end = *(real_mode + 0x201);
>
> real_mode[0x201] might be clearer...
>
>> +     end += 0x202;
>> +     if (end < size)
>> +             memset(real_mode + end, 0, size - end);
>> +}
>
> You don't actually need the test... the value is inherently smaller than
> 0x301 which is less than the size.
>
> That being said, if you want to sanity-check it you can check that the
> value is in a sensible range -- the permitted range is 0x22 to 0x7f
> inclusive, corresponding to a total end value of 0x224 to 0x281.

yes.

how about clear all and copy only setup_header?

that looks more readable.

Index: kexec-tools/kexec/arch/i386/kexec-bzImage.c
===================================================================
--- kexec-tools.orig/kexec/arch/i386/kexec-bzImage.c
+++ kexec-tools/kexec/arch/i386/kexec-bzImage.c
@@ -211,7 +211,16 @@ int do_bzImage_load(struct kexec_info *i
        /* The argument/parameter segment */
        setup_size = kern16_size + command_line_len + PURGATORY_CMDLINE_SIZE;
        real_mode = xmalloc(setup_size);
-       memcpy(real_mode, kernel, kern16_size);
+       if (!real_mode_entry) {
+               unsigned long size = kernel[0x201] + 0x202 - 0x1f1;
+
+               /* only copy setup_header */
+               memset(real_mode, 0, setup_size);
+               if (size > 0x7f)
+                       size = 0x7f;
+               memcpy(real_mode + 0x1f1, kernel + 0x1f1, size);
+       } else
+               memcpy(real_mode, kernel, kern16_size);

        if (info->kexec_flags & (KEXEC_ON_CRASH | KEXEC_PRESERVE_CONTEXT)) {
                /* If using bzImage for capture kernel, then we will not be

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
