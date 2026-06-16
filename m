Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1842BCD98DA
	for <kexec@archiver.kernel.org>; Tue, 16 Jun 2026 10:32:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:MIME-Version:References:Message-ID:Subject:Cc:To:
	From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=KvXTWCj09i+bN9kNXDEOU/hGM9QyrgANeIR6EQfcXZY=; b=ChjnPdgR9BsXZpKKnr5F3ButCk
	CNl4Nl+u4JVY70OlUi9qczhmIkatkTTq4VcHlju947pnwvjIxJ09LOLpKtjF/iP2nbytfF14opSMK
	tWTokZWhieeJ6gMy6Sx0B3yjHxkDHwd6FIG3VbhCD93CFA81ltSwQj9FhlgDMguEZFCFIPD/KdKu8
	Nu6Ih/Jn2V/l+gw1jsrc0deKgQadKIi0lDQN8Q4vVS9EAidoMC/6NBH/KRlW0+c8Z/cpR58Vybvg7
	b3bzoc0gKuAkkb+5mMphO31qT3qI0CRDSmbbyQ8adxUZqSoMATj51kbthE32j/xn2gOtkP+CPUc6z
	6394oshA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wZR5P-0000000Fc3g-30mK;
	Tue, 16 Jun 2026 10:32:03 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wZR5K-0000000Fc3B-0PjP
	for kexec@lists.infradead.org;
	Tue, 16 Jun 2026 10:32:00 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1781605916;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KvXTWCj09i+bN9kNXDEOU/hGM9QyrgANeIR6EQfcXZY=;
	b=TUvN0FCBuejso0RkoERvJhtXIwCnB3XVCmaFTCi5ECVE4ElK1YkHoVguYZ764n7RzxwU35
	+mUCz5FPO62XE4Jb8UYvrKjnn2T3Kfi60tLhDIn2+Y9ufGkdcggCQil+PEwHXRbLKGUFgQ
	TroPGFoKx+W205TAqbxbKZHv4V6MKuc=
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-440-E2f0lSCzNwq6YP_bjVwdww-1; Tue, 16 Jun 2026 06:31:55 -0400
X-MC-Unique: E2f0lSCzNwq6YP_bjVwdww-1
X-Mimecast-MFC-AGG-ID: E2f0lSCzNwq6YP_bjVwdww_1781605914
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2c0532a6588so42007305ad.0
        for <kexec@lists.infradead.org>; Tue, 16 Jun 2026 03:31:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781605914; x=1782210714;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KvXTWCj09i+bN9kNXDEOU/hGM9QyrgANeIR6EQfcXZY=;
        b=GNBlSa4Td8nS8lWiuDf6VFY8DOT4IbkzIgVHCgK1nwVktgVCjdpieWc64XZWvXiz+I
         MYNHFYulu0pBuCcniWVnYFQ1H6bEmoTwjie14fEnO+Ra3V+FaW2bGLYkQN9vz9PvJG9n
         N+Yme5gtj+ak708d5uXY/trhN5l1uXwfKzWj4fO9E+jIjF2LoLFJiF/yBoXvGr4I6IQg
         F+Eo42FhhmaugdoyMzSiy2AdlIQOs7v3Hnqq8KXRF/wfC6HkC0MYsvSnxY6fDuJjKuXw
         W1RDUTbZOAXcksjU70fGQXLHo3T7QY1d+YAbmKNZl35QA1YBCUHVJT0hA4FeRZL3qU14
         cRJA==
X-Forwarded-Encrypted: i=1; AFNElJ+GJB3M0nAHdfuLkeKITC3XgoSzCDpo+GymmZWwewA9/z3jDyEGyx63vulMNv11Ye7/H66jJA==@lists.infradead.org
X-Gm-Message-State: AOJu0YzEgARxStuByfVWujCnqVXZpOxIraLRU32VSYIC59JtDDdi+5uD
	9qln6HsrD3eHpXiCBTt6aqbzPDx8P3x7OoNYvLgJki5k3e9y6SZrIXOx7Juxq63QNe43uDSy7CM
	nEUq4WyDYBIeF4PeE0YW/5DMrX1nCHhNZM/cp4FY0E1MZtOLHRg4eKD/yLucXzw==
X-Gm-Gg: Acq92OGeSGRrt21pr2+cOVfeUHKpM/pExjB8FEbj1kaRqsrt1iaMYozKBjrGPByoLeN
	Z2o7l/+tZN24O8c/jWqgAHi7ckDZUDtLRX1ehRK/ywPLVPgEAulBoveIn8KPUAcrOhwstkzIEYX
	Tdfn69SoqMr/8msq6pEepxh2X2uyJE/k9DcREXNJx8uPjyDfVCmVwvTk+TXPFJ20SuhNIMkGoI+
	h3KahbzfavFeq7wy/b4pnHXidkiXU6ein5PmrIzxGmqWZe0F1PpOFveTkQN3YGwpr2dRfkfPsZK
	0U2TrUzZz6uy8AzIBwCp9ibYOoZaB9YUcRj2EW72CaXv9zLhjbTzMBIp42jl5UtrDSxYE5XYToU
	QyRsifz9zguhOJLv1HnjhtLiFNCdEZa0crbx3wd7zyR0AF+FTgLesHDNAdM3U
X-Received: by 2002:a17:903:2f4c:b0:2c0:a373:89bf with SMTP id d9443c01a7336-2c6641caa55mr159313545ad.1.1781605914156;
        Tue, 16 Jun 2026 03:31:54 -0700 (PDT)
X-Received: by 2002:a17:903:2f4c:b0:2c0:a373:89bf with SMTP id d9443c01a7336-2c6641caa55mr159313025ad.1.1781605913598;
        Tue, 16 Jun 2026 03:31:53 -0700 (PDT)
Received: from localhost.localdomain (122-63-68-77.mobile.spark.co.nz. [122.63.68.77])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c43336937fsm130634585ad.72.2026.06.16.03.31.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jun 2026 03:31:53 -0700 (PDT)
Date: Tue, 16 Jun 2026 22:31:46 +1200
From: Tao Liu <ltao@redhat.com>
To: HAGIO =?utf-8?B?S0FaVUhJVE8o6JCp5bC+44CA5LiA5LuBKQ==?= <k-hagio-ab@nec.com>
Cc: Stephen Brennan <stephen.s.brennan@oracle.com>,
	YAMAZAKI =?utf-8?B?TUFTQU1JVFNVKOWxseW0juOAgOecn+WFiSk=?= <yamazaki-msmt@nec.com>,
	"kexec@lists.infradead.org" <kexec@lists.infradead.org>
Subject: Re: [PATCH v5][makedumpfile 6/9] Add makedumpfile extensions support
Message-ID: <ajEmEtudVb_YqEkM@localhost.localdomain>
References: <20260414102656.55200-1-ltao@redhat.com>
 <20260414102656.55200-7-ltao@redhat.com>
 <8b0079dd-e50a-4667-aabf-1612921b022a@nec.com>
 <874ij3zq1k.fsf@oracle.com>
 <CAO7dBbU6V7XYYO9M+z_CK8UCnzfX7TB7DZka4Z_kqP-WvDbTaA@mail.gmail.com>
 <f15ae344-bdcc-48a1-9c7b-0ea264d061d4@nec.com>
 <CAO7dBbXLBX9_Ut9yQDkOr3pWq-mSx-5=tMUU9FL83eA3Lz0c_g@mail.gmail.com>
 <ab1b5e58-bad6-4565-a408-b1fb3d489465@nec.com>
MIME-Version: 1.0
In-Reply-To: <ab1b5e58-bad6-4565-a408-b1fb3d489465@nec.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: PHprX-jwIBBjP_iX643633K6bfIu-8g66d-ANw3Bc6A_1781605914
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260616_033158_258638_889A42E3 
X-CRM114-Status: GOOD (  45.81  )
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
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

Hi Kazu,

On Tue, Jun 16, 2026 at 07:51:47AM +0000, HAGIO KAZUHITO(萩尾 一仁) wrote:
> On 2026/06/16 11:17, Tao Liu wrote:
> > On Tue, Jun 16, 2026 at 1:39 PM HAGIO KAZUHITO(萩尾　一仁)
> > <k-hagio-ab@nec.com> wrote:
> >>
> >> On 2026/06/16 8:03, Tao Liu wrote:
> >>> Hi Stephen & Kazu,
> >>>
> >>> On Tue, Jun 16, 2026 at 5:12 AM Stephen Brennan
> >>> <stephen.s.brennan@oracle.com> wrote:
> >>>>
> >>>> HAGIO KAZUHITO(萩尾　一仁)   <k-hagio-ab@nec.com> writes:
> >>>>> On 2026/04/14 19:26, Tao Liu wrote:
> >>>>>
> >>>>>> +static bool init_kallsyms_btf(void)
> >>>>>> +{
> >>>>>> +    int count;
> >>>>>> +    bool ret = false;
> >>>>>> +    /* We will load module's btf/kallsyms on demand */
> >>>>>> +    bool init_ksyms_module = false;
> >>>>>> +    bool init_ktypes_module = false;
> >>>>>> +
> >>>>>> +    if (check_ksyms_require_modname("vmlinux", &count)) {
> >>>>>
> >>>>> Thank you for the explanation [1].
> >>>>>
> >>>>> so which code path adds "vmlinux" to the mods array before this line?
> >>>>> I could not find it.
> >>>>
> >>>> Hello Kazu,
> >>>>
> >>>> In kallsyms.c from patch 2, there is the line:
> >>>>     INIT_MOD_SYM(vmlinux, _stext);
> >>>> This adds a struct ksym_info to the main makedumpfile executable's
> >>>> array, which requests symbol "_stext" from vmlinux.
> >>>>
> >>>> In kallsyms.c "init_kernel_kallsyms()", again from patch 2, the first
> >>>> step is to call:
> >>>>      register_ksym_section((char *)__start_init_ksyms,
> >>>>                            (char *)__stop_init_ksyms))
> >>>> Which is a function generated by the macro REGISTER_SECTION(). The
> >>>> implementation will use add_ksym_modname() whens it encounters this
> >>>> symbol, ensuring that "vmlinux" is part of the modname array.
> >>>
> >>> Thanks for the detailed info, yes, it is exactly how "vmlinux" is
> >>> added to the array.
> >>
> >> hmm, maybe I still misread it though..
> >>
> >> The init_kernel_kallsyms() is called _after_ check_ksyms_require_modname().
> >> so I've meant that if no extension adds "vmlinux" to the modname array,
> >> no one calls it.  is it ok?
> >>
> >>           if (check_ksyms_require_modname("vmlinux", &count)) {
> >>                   if (!init_kernel_kallsyms())
> > 
> > No, even if you create a extension which doesn't require symbols from
> > "vmlinux", once you load it, the check_ksyms_require_modname() will
> > still be true and init_kernel_kallsyms() is called.
> > 
> > The reason is, with the introduction of makedumpfile.ld, and the line
> > "INIT_MOD_SYM(vmlinux, _stext);" in kallsyms.c, makedumpfile and
> > extensions have a similar section structure, you can regard
> > makedumpfile itself as an extension:
> > 
> > $ readelf -S makedumpfile | grep -E 'ksyms|ktypes'
> >    [25] .init_ksyms       PROGBITS         000000000046ee90  0006de90
> >    [26] .init_ktypes      PROGBITS         000000000046eeb8  0006deb8
> > $ readelf -S extensions/sample.so | grep -E 'ksyms|ktypes'
> >    [24] .init_ksyms       PROGBITS         0000000000003108  00002108
> >    [25] .init_ktypes      PROGBITS         0000000000003110  00002110
> > 
> > If makedumpfile doesn't load any extensions, then makedumpfile doesn't
> > need to initialize its .init_ksyms/ktypes section, the behaviour stays
> > the same as before;
> > If makedumpfile load at least one extensions, then the extension
> > subsystem will register all .init_ksyms/ktypes sections, both
> > extenison's and makedumpfile's.
> > 
> > This is like, extension say "I need sym1 & sym2 to be ready before I
> > can run", then makedumpfile say "OK, I got it, but before I can
> > resolve your sym1 & sym2, I need to resolve some symbol(e.g. vmlinux's
> > _stext) formyself first". So check_ksyms_require_modname("vmlinux",
> > &count) will be true.
> 
> hmm, but as far as I've tested with "extensions/sample.c" on RHEL10.2:
> 
> 1) add INIT_MOD_SYM(xfs, xfsstats) and GET_MOD_SYM(xfs, xfsstats)
> 
> ok
> 
> Loaded extension: /share/tmp/makedumpfile/extensions/sample.so
> sample.so: The address of xfsstats is: ffffffffc0c0b540   <<--- ok
> sample.so: The address of init_task is: ffffffffb4412940
> sample.so: The size of task_struct is: 10240 bytes
> sample.so: The offset of member mm within task_struct is: 2704 bytes
> sample.so: The size of member mm within task_struct is: 8 bytes
> sample.so: Your kernel is using maple tree in mm_struct
> 
> 2) remove all "vmlinux" entries (only INIT_MOD_SYM(xfs, xfsstats))
> 
> skipped
> 
> Loaded extension: /share/tmp/makedumpfile/extensions/sample.so
> check_required_ksyms_all_resolved: Symbol xfsstats in xfs not found
> init_extensions: Skip 1th extension
> 

This is a bug which shouldn't happen, thanks for pointing it out.

> 3) restore INIT_MOD_SYM(vmlinux, init_task) and GET_MOD_SYM(vmlinux, init_task)
> 
> still skipped
> 
> Loaded extension: /share/tmp/makedumpfile/extensions/sample.so
> check_required_ksyms_all_resolved: Symbol xfsstats in xfs not found
> init_extensions: Skip 1th extension
> 

Also a bug. I made a code modification based on the v5 to fix, could you please
give a try? If no problem I will integrate it with v6.

diff --git a/btf_info.c b/btf_info.c
index 1506152..fbb487b 100644
--- a/btf_info.c
+++ b/btf_info.c
@@ -202,10 +202,6 @@ bool init_kernel_btf(void)
 		goto out;
 	}
 
-	if (!register_ktype_section((char *)__start_init_ktypes,
-				    (char *)__stop_init_ktypes))
-		return ret;
-
 	size = stop_btf - start_btf;
 	buf = (char *)malloc(size);
 	if (!buf) {
diff --git a/extension.c b/extension.c
index 190dd9e..276ffb1 100644
--- a/extension.c
+++ b/extension.c
@@ -153,7 +153,7 @@ static void load_extensions(void)
 	}
 }
 
-static bool register_extension_sections(void)
+static bool register_ksyms_ktypes_sections(void)
 {
 	char *start, *stop;
 	int i;
@@ -170,6 +170,18 @@ static bool register_extension_sections(void)
 		if (!register_ktype_section(start, stop))
 			goto out;
 	}
+	/* If no extensions, don't register makedumpfile's section */
+	if (handle_cbs_len > 0) {
+		start = dlsym(NULL, "__start_init_ksyms");
+		stop = dlsym(NULL, "__stop_init_ksyms");
+		if (!register_ksym_section(start, stop))
+			goto out;
+
+		start = dlsym(NULL, "__start_init_ktypes");
+		stop = dlsym(NULL, "__stop_init_ktypes");
+		if (!register_ktype_section(start, stop))
+			goto out;
+	}
 	ret = true;
 out:
 	return ret;
@@ -260,7 +272,7 @@ void init_extensions(void)
 	void (*init)(void);
 
 	load_extensions();
-	if (!register_extension_sections())
+	if (!register_ksyms_ktypes_sections())
 		goto fail;
 	if (!init_kallsyms_btf()) 
 		goto fail;
diff --git a/kallsyms.c b/kallsyms.c
index f231a06..0037600 100644
--- a/kallsyms.c
+++ b/kallsyms.c
@@ -276,10 +276,6 @@ bool init_kernel_kallsyms(void)
 		return ret;
 	}
 
-	if (!register_ksym_section((char *)__start_init_ksyms,
-				   (char *)__stop_init_ksyms))
-		return ret;
-
 	if (!readmem(VADDR, SYMBOL(kallsyms_num_syms), &kallsyms_num_syms,
 		sizeof(kallsyms_num_syms))) {
 		ERRMSG("Can't get kallsyms_num_syms!\n");


> 4) also restore INIT_MOD_STRUCT_MEMBER(vmlinux, task_struct, mm) and
>     GET_MOD_STRUCT_MEMBER_SSIZE(vmlinux, task_struct, mm)
> 
> ok
> 
> Loaded extension: /share/tmp/makedumpfile/extensions/sample.so
> sample.so: The address of xfsstats is: ffffffffc0c0b540
> sample.so: The address of init_task is: ffffffffb4412940
> sample.so: The size of task_struct is: 10240 bytes
> 
> 
> So, it looks like, with the current condition check in init_kallsyms_btf()
> (check_ksyms_require_modname and check_ktypes_require_modname),
> a module needs to use INIT_* for vmlinux's kallsyms and BTF.
> 
> I'm still missing something..?
> 
> Thanks,
> Kazu


