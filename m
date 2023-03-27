Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3C5AC7619A
	for <kexec@archiver.kernel.org>; Mon, 27 Mar 2023 11:52:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Cc:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=j+jLPF8co+CHNk//63vIo2Da1EO2xeraHd+h5Ph7a/I=; b=tE8K3b5lu84P3c
	Hr/YyoSXvfBC4t2ehj57WM28Lf5ks1LDEc8lrpaNtOZYygsNUfJg3OV9VTaADhIKbguelHFlWwgDr
	T7U9YeMSlvzuXeohbLYDUdTQ4fySG/4gXVbLUgtj0obVfZ8ivoTUtThFwH2q7FqUPwyEc3flT0dAC
	bD7bVtWE+lM0JSt0a4PW+s4LNgxE0mtE5Xsc3xtrxxMWNosNDaXRZmAVR1D+ZMl5kxViD9U+COCUh
	VNJRrmeQgixcic8dV19vgwH8x52eAa47+2kZeRwRRXiTFBNqCIk8PvwqAI50MVro28650U9sTIXnv
	4wgEBUpY9WLxoFRjHaww==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pglOl-00AnT0-20;
	Mon, 27 Mar 2023 11:52:27 +0000
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pglOi-00AnRZ-09
	for kexec@lists.infradead.org;
	Mon, 27 Mar 2023 11:52:25 +0000
Received: by mail-pl1-x62a.google.com with SMTP id o2so8172389plg.4
        for <kexec@lists.infradead.org>; Mon, 27 Mar 2023 04:52:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1679917941;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Yie29ohMrJ3Z0GW7KYTY2gK6o38sOzg3sKUuuNau8C0=;
        b=OQZDKtpUc7OBSFoH1VyVCKHCxN7Ne5b14OAG2MvHFVomO+Kly0QsA1BIT/ftdvm27v
         G5lFHxcsgUQJCrEQxOPON8WVITL+k9cJjfUbfcbIyH4siFMvOYHOwp53B4VqzgzIcm7k
         gy5XqO8SNq2c+0QdFR3sGPjK6BK2iMm7XrS+M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679917941;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Yie29ohMrJ3Z0GW7KYTY2gK6o38sOzg3sKUuuNau8C0=;
        b=pjP/18jIgsHIcUg84xOFpmGzMjsZe8lcklpxi6g161WQzZhiAlc4RWc/bmc90Pjd5u
         49GOVZXvSACcLY2OUq0n/zImoaW4CR31ivMMtLKMeglAyAQkHv9mPP3yN8+1IMLgqmFr
         lDon50+bzwxY2cqhCV+nS4cBbY29pEBnGE+jeUyybTpWoYN+T68BmIO3W6ZHnfhtrUsQ
         DBCmdHxvxVppyqxLmnVpli7K22BmY37wu5GYiiFOduMqrwyd4YCVl+3YyaX0p71i1iVL
         ujfoP+zA5SdnuNxh2h6MZuXgGU9V8tFAqWXgW1EpCJpadvjxeKCcWiJJ+LTbwL4Uznhh
         RO5Q==
X-Gm-Message-State: AAQBX9c70Vd983u9Kz3MWAy3M3uR73mqhlrn2zRpkILSI3CRYFBjmyP+
	FGf/SIH7vCOYeaCb5JgVgSn12a3xpCIL8CWc8w0=
X-Google-Smtp-Source: AKy350YYbTdMn3sJfsjWYwpulNoHLo+swzmA5fwV+SG0YRduXcD56HXxyXxLZ+O3TWnN+NZiTkxm3Q==
X-Received: by 2002:a17:90b:4d0d:b0:233:cd29:f168 with SMTP id mw13-20020a17090b4d0d00b00233cd29f168mr12757245pjb.24.1679917941521;
        Mon, 27 Mar 2023 04:52:21 -0700 (PDT)
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com. [209.85.210.181])
        by smtp.gmail.com with ESMTPSA id mn13-20020a17090b188d00b002372106a5casm7396318pjb.44.2023.03.27.04.52.20
        for <kexec@lists.infradead.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Mar 2023 04:52:20 -0700 (PDT)
Received: by mail-pf1-f181.google.com with SMTP id u38so5450824pfg.10
        for <kexec@lists.infradead.org>; Mon, 27 Mar 2023 04:52:20 -0700 (PDT)
X-Received: by 2002:a65:648c:0:b0:4eb:1c07:e5d7 with SMTP id
 e12-20020a65648c000000b004eb1c07e5d7mr3048091pgv.6.1679917939815; Mon, 27 Mar
 2023 04:52:19 -0700 (PDT)
MIME-Version: 1.0
References: <20230321-kexec_clang16-v3-0-5f016c8d0e87@chromium.org> <20230324165855.23084947@rotkaeppchen>
In-Reply-To: <20230324165855.23084947@rotkaeppchen>
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Mon, 27 Mar 2023 13:52:08 +0200
X-Gmail-Original-Message-ID: <CANiDSCtu8oOn9vV9eak=S2RDVVO9yan2BO8K5ia9jALABqiwjQ@mail.gmail.com>
Message-ID: <CANiDSCtu8oOn9vV9eak=S2RDVVO9yan2BO8K5ia9jALABqiwjQ@mail.gmail.com>
Subject: Re: [PATCH v3] kexec: Support purgatories with .text.hot sections
To: Philipp Rudo <prudo@redhat.com>
Cc: Eric Biederman <ebiederm@xmission.com>, linux-kernel@vger.kernel.org, 
	kexec@lists.infradead.org, Baoquan He <bhe@redhat.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230327_045224_112192_B11CB31B 
X-CRM114-Status: GOOD (  46.60  )
X-BeenThere: kexec@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
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
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

Hi Philipp



On Fri, 24 Mar 2023 at 17:00, Philipp Rudo <prudo@redhat.com> wrote:
>
> Hi Ricardo,
>
> On Wed, 22 Mar 2023 20:09:21 +0100
> Ricardo Ribalda <ribalda@chromium.org> wrote:
>
> > Clang16 links the purgatory text in two sections:
> >
> >   [ 1] .text             PROGBITS         0000000000000000  00000040
> >        00000000000011a1  0000000000000000  AX       0     0     16
> >   [ 2] .rela.text        RELA             0000000000000000  00003498
> >        0000000000000648  0000000000000018   I      24     1     8
> >   ...
> >   [17] .text.hot.        PROGBITS         0000000000000000  00003220
> >        000000000000020b  0000000000000000  AX       0     0     1
> >   [18] .rela.text.hot.   RELA             0000000000000000  00004428
> >        0000000000000078  0000000000000018   I      24    17     8
> >
> > And both of them have their range [sh_addr ... sh_addr+sh_size] on the
> > area pointed by `e_entry`.
> >
> > This causes that image->start is calculated twice, once for .text and
> > another time for .text.hot. The second calculation leaves image->start
> > in a random location.
> >
> > Because of this, the system crashes inmediatly after:
> >
> > kexec_core: Starting new kernel
>
> Great analysis!
>
> > Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
> > ---
> > kexec: Fix kexec_file_load for llvm16
> >
> > When upreving llvm I realised that kexec stopped working on my test
> > platform. This patch fixes it.
> >
> > To: Eric Biederman <ebiederm@xmission.com>
> > Cc: Baoquan He <bhe@redhat.com>
> > Cc: Philipp Rudo <prudo@redhat.com>
> > Cc: kexec@lists.infradead.org
> > Cc: linux-kernel@vger.kernel.org
> > ---
> > Changes in v3:
> > - Fix initial value. Thanks Ross!
> > - Link to v2: https://lore.kernel.org/r/20230321-kexec_clang16-v2-0-d10e5d517869@chromium.org
> >
> > Changes in v2:
> > - Fix if condition. Thanks Steven!.
> > - Update Philipp email. Thanks Baoquan.
> > - Link to v1: https://lore.kernel.org/r/20230321-kexec_clang16-v1-0-a768fc2c7c4d@chromium.org
> > ---
> >  kernel/kexec_file.c | 13 ++++++++++++-
> >  1 file changed, 12 insertions(+), 1 deletion(-)
> >
> > diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
> > index f1a0e4e3fb5c..25a37d8f113a 100644
> > --- a/kernel/kexec_file.c
> > +++ b/kernel/kexec_file.c
> > @@ -901,10 +901,21 @@ static int kexec_purgatory_setup_sechdrs(struct purgatory_info *pi,
> >               }
> >
> >               offset = ALIGN(offset, align);
> > +
> > +             /*
> > +              * Check if the segment contains the entry point, if so,
> > +              * calculate the value of image->start based on it.
> > +              * If the compiler has produced more than one .text sections
> > +              * (Eg: .text.hot), they are generally after the main .text
> > +              * section, and they shall not be used to calculate
> > +              * image->start. So do not re-calculate image->start if it
> > +              * is not set to the initial value.
> > +              */
> >               if (sechdrs[i].sh_flags & SHF_EXECINSTR &&
> >                   pi->ehdr->e_entry >= sechdrs[i].sh_addr &&
> >                   pi->ehdr->e_entry < (sechdrs[i].sh_addr
> > -                                      + sechdrs[i].sh_size)) {
> > +                                      + sechdrs[i].sh_size) &&
> > +                 kbuf->image->start == pi->ehdr->e_entry) {
>
> I'm not entirely sure if this is the solution to go with. As you state
> in the comment above this solution assumes that the .text section comes
> before any other .text.* section. But this assumption isn't much
> stronger than the assumption that there is only a single .text section,
> which is used nowadays.
>
> The best solution I can come up with right now is to introduce a linker
> script for the purgatory that simply merges the .text sections into
> one. Similar to what I did for s390 in
> arch/s390/purgatory/purgatory.lds.S (although for a different reason).
> But that would require every architecture to get one. An alternative
> would be to find a way to get rid of the -r option on the LD_FLAGS,
> which IIRC is the reason why both section overlap in the first place.


I tried removing the -r from arch/x86/purgatory/Makefile and that resulted into:

[  115.631578] BUG: unable to handle page fault for address: ffff93224d5c8e20
[  115.631583] #PF: supervisor write access in kernel mode
[  115.631585] #PF: error_code(0x0002) - not-present page
[  115.631586] PGD 100000067 P4D 100000067 PUD 1001ed067 PMD 132b58067 PTE 0
[  115.631589] Oops: 0002 [#1] PREEMPT SMP NOPTI
[  115.631592] CPU: 0 PID: 5291 Comm: kexec-lite Tainted: G     U
      5.15.103-17399-g852a928df601-dirty #19
cd159e0d6a91f03e06035a0a8eb7fc984a8f3e82
[  115.631594] Hardware name: Google Crota/Crota, BIOS
Google_Crota.14505.288.0 11/08/2022
[  115.631595] RIP: 0010:memcpy_erms+0x6/0x10
[  115.631599] Code: 5d 00 eb bd eb 1e 0f 1f 00 48 89 f8 48 89 d1 48
c1 e9 03 83 e2 07 f3 48 a5 89 d1 f3 a4 c3 cc cc cc cc 66 90 48 89 f8
48 89 d1 <f3> a4 c3 cc cc cc cc 0f 1f 00 48 89 f8 48 83 fa 20 72 7e 40
38 fe
[  115.631601] RSP: 0018:ffff93224f65fe50 EFLAGS: 00010246
[  115.631602] RAX: ffff93224d5c8e20 RBX: 00000000ffffffea RCX: 0000000000000100
[  115.631603] RDX: 0000000000000100 RSI: ffff9322407bd000 RDI: ffff93224d5c8e20
[  115.631604] RBP: ffff93224f65fe88 R08: 0000000000000000 R09: ffff92133cd3ef08
[  115.631605] R10: ffff9322407be000 R11: ffffffffa1b4f2e0 R12: 0000000000000000
[  115.631606] R13: ffff92133cee4c00 R14: 0000000000000100 R15: ffffffffa2b6f14f
[  115.631607] FS:  000078e8b9dbf7c0(0000) GS:ffff921437800000(0000)
knlGS:0000000000000000
[  115.631609] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  115.631610] CR2: ffff93224d5c8e20 CR3: 000000015be26001 CR4: 0000000000770ef0
[  115.631611] PKRU: 55555554
[  115.631612] Call Trace:
[  115.631614]  <TASK>
[  115.631615]  kexec_purgatory_get_set_symbol+0x82/0xd3
[  115.631619]  __se_sys_kexec_file_load+0x523/0x644
[  115.631621]  do_syscall_64+0x58/0xa5
[  115.631623]  entry_SYSCALL_64_after_hwframe+0x61/0xcb


And I did not continue in that direction.

I also tried finding a flag for llvm that would avoid splitting .text,
but was not lucky either.

I will look into making a linker script for x86, we could combine it
with something like:

                if (sechdrs[i].sh_flags & SHF_EXECINSTR &&
                    pi->ehdr->e_entry >= sechdrs[i].sh_addr &&
                    pi->ehdr->e_entry < (sechdrs[i].sh_addr
-                                        + sechdrs[i].sh_size) &&
-                   kbuf->image->start == pi->ehdr->e_entry) {
-                       kbuf->image->start -= sechdrs[i].sh_addr;
-                       kbuf->image->start += kbuf->mem + offset;
+                                        + sechdrs[i].sh_size)) {
+                       if (!WARN_ON(kbuf->image->start != pi->ehdr->e_entry)) {
+                               kbuf->image->start -= sechdrs[i].sh_addr;
+                               kbuf->image->start += kbuf->mem + offset;
+                       }
                }

So developers have some hints of what to look at.

Thanks!


>
> Thanks
> Philipp
>
> >                       kbuf->image->start -= sechdrs[i].sh_addr;
> >                       kbuf->image->start += kbuf->mem + offset;
> >               }
> >
> > ---
> > base-commit: 17214b70a159c6547df9ae204a6275d983146f6b
> > change-id: 20230321-kexec_clang16-4510c23d129c
> >
> > Best regards,
>


-- 
Ricardo Ribalda

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
