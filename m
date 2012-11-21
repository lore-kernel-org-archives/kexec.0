Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-bk0-f49.google.com ([209.85.214.49])
 by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1TbGQA-0000YS-Ku
 for kexec@lists.infradead.org; Wed, 21 Nov 2012 19:57:20 +0000
Received: by mail-bk0-f49.google.com with SMTP id jm19so1893348bkc.36
 for <kexec@lists.infradead.org>; Wed, 21 Nov 2012 11:57:17 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <50AD310F.8000809@zytor.com>
References: <1353483098-14883-1-git-send-email-yinghai@kernel.org>
 <1353483098-14883-5-git-send-email-yinghai@kernel.org>
 <20121121145023.GD13114@redhat.com>
 <CAE9FiQUHapB8_uGwMtM84xOHpMvWmVbn2Z8h0C=n_rfHPCbY_g@mail.gmail.com>
 <50AD310F.8000809@zytor.com>
Date: Wed, 21 Nov 2012 11:57:17 -0800
Message-ID: <CAE9FiQUeu_jJxHL_+w06HK2kdJZhfZuh78fk3vwGs_+a13ik6A@mail.gmail.com>
Subject: Re: [PATCH v3 4/4] kexec, x86_64: Load bzImage64 above 4G
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
Cc: Haren Myneni <hbabu@us.ibm.com>, Simon Horman <horms@verge.net.au>, kexec@lists.infradead.org, "Eric W. Biederman" <ebiederm@xmission.com>, Vivek Goyal <vgoyal@redhat.com>

On Wed, Nov 21, 2012 at 11:52 AM, H. Peter Anvin <hpa@zytor.com> wrote:
> On 11/21/2012 11:50 AM, Yinghai Lu wrote:
>>>
>>> So how do I force a 16bit or 32bit entry using a bzImage64?
>>
>> kexec -t bzImage -l ....
>> will load low and use 32bit entry.
>>
>> kexec -t bzImage64 -l ...
>> kexec -l ...
>> will try to load high and use 64bit entry.
>>

>
> I don't see any difference...
>


--- a/kexec/arch/x86_64/kexec-x86_64.c
+++ b/kexec/arch/x86_64/kexec-x86_64.c
@@ -37,6 +37,7 @@ struct file_type file_type[] = {
        { "multiboot-x86", multiboot_x86_probe, multiboot_x86_load,
          multiboot_x86_usage },
        { "elf-x86", elf_x86_probe, elf_x86_load, elf_x86_usage },
+       { "bzImage64", bzImage64_probe, bzImage64_load, bzImage64_usage },
        { "bzImage", bzImage_probe, bzImage_load, bzImage_usage },
        { "beoboot-x86", beoboot_probe, beoboot_load, beoboot_usage },
        { "nbi-x86", nbi_probe, nbi_load, nbi_usage },

bzImage64_probe will be run before bzImage_probe.

and if it find that is 64bit, bzImage_probe will not be executed.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
