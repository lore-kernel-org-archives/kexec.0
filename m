Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 551E7C0218D
	for <kexec@archiver.kernel.org>; Mon, 27 Jan 2025 02:42:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:Subject:
	Message-ID:Date:From:In-Reply-To:References:MIME-Version:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=wu0a707gzjddAHWMPI2oWMzR7Qn7O3ssR0hVwCALi5E=; b=N/ITUPkvCDjrDV2SegZTs75NOd
	8k5lEszAVBZlyxeozihFR4hXx7OhfRiG1nBt9UXLhZ/iCVi4TpnaMp920dzYF5oAMCKeFhIi+oLol
	6ZC0i71iF0SuWAhH/gPJ0D/Nonwpwa2eRoKB4d4O7FMGtP5mH2fxltPkOSntpwqyPB39J/agUWLJ4
	3ULAniGISYLdKUXsG2T3GKCuvmN0Oktr20EqEj40HCW4uNcgfT2lARQZCF0mWkuHWeX45qRozvtnR
	7kfmoZuN07jYFmBPqx/JhI6bRhe+DIMuM4Cisf+5wyX9eOJbGV1gjcKgf4hkf+RZlj2bpxnY6saQW
	cZg9Nz3g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tcF4c-00000001Wmo-3RRC;
	Mon, 27 Jan 2025 02:42:02 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tcF4Z-00000001WkP-2QgM
	for kexec@lists.infradead.org;
	Mon, 27 Jan 2025 02:42:00 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1737945717;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=wu0a707gzjddAHWMPI2oWMzR7Qn7O3ssR0hVwCALi5E=;
	b=MktvDWXsmGQYlHtCblCZZFpWRezDlLIWFfI4CSeSF3WfH5G6XOznzhbKVFTcuAAWRxbAUI
	Jv1BH65Lz7/3Q+TYSPoJ6utHC9G77SoSi0r5qmklOwPHr/pSF/tSOWq0iXWIvi5LowLNnL
	NfDCyV4qdTL+oHBhN23Bp07yOUz8bbQ=
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com
 [209.85.166.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-460-YlKxMvQhOYa2U5Jkf98J0g-1; Sun, 26 Jan 2025 21:41:56 -0500
X-MC-Unique: YlKxMvQhOYa2U5Jkf98J0g-1
X-Mimecast-MFC-AGG-ID: YlKxMvQhOYa2U5Jkf98J0g
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-3cfba1ca53bso29182075ab.3
        for <kexec@lists.infradead.org>; Sun, 26 Jan 2025 18:41:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737945715; x=1738550515;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wu0a707gzjddAHWMPI2oWMzR7Qn7O3ssR0hVwCALi5E=;
        b=KSPaSzO48+/oaowRJzNBqNX+j94kv8T3Sh/Y4HMnqbpg5hTGi8Jl5uBlGSJETmS/Fn
         bJyTD9ks7dmzRX4Z1MANXUMhRBhgE1faM1bIoxxYApWPGtDm6QfOSQ4PB/Iy2WReknyB
         zK62/zz6lU4auVeZdPykzEG2RTua8wm/5XlPK28445eW6i53c9LDxzX8s3hzaTArGTtV
         luPwDQW6hjaFcXCGTSn1L0ZbOs7UYBrdhSnIHlM1DP4ZqmRp1SWJigooq4gBW+TitgCP
         613cere+eBLJd9mPSS7uBRdUokip0cuceXos1Zns/7VNDNOWaqQQKufNFqdwiCw+zmoL
         8kPw==
X-Forwarded-Encrypted: i=1; AJvYcCUyHUhBFkzG0GZreWi2eiQ4vVdjC7LypstU90BpFpUlyLEyjdT0QS3tn/SybWDkpuxyfzq1LQ==@lists.infradead.org
X-Gm-Message-State: AOJu0YwZM6MCmqWDaMGlLqbWeLRksnWvJDCMLt9TxudDXvisOBG4GzvL
	TaXxVfkHxV6YuUztHTxSELJYiOSoOHmXqI4S8hUh/IHUqtJY1VzM6McGjDnaRZOdSm2Aw7TVelY
	qjMDMFm4LnP3lCCfNIvKk6IZT0P2amd2UTTqFx6mDtQ+2fCRrEjIZco0LsB4Z/M9uIWMKN4tEQd
	dX4EJvsVCDkr5kb08cbuEG5L/7iHYXbzQF
X-Gm-Gg: ASbGnctUDnZhLyx0jYH1D5k8HceDu8RsY+eBg2CR/o2dHe66IpJpeIZwa8RifiZs6eN
	JCM1Qfr0iqueI1OZOldaBAJCs9J8RealgU0m0Iyw4F2iiwyjZKV5c1du4+nU7yuk=
X-Received: by 2002:a92:cd85:0:b0:3cf:cac9:b02d with SMTP id e9e14a558f8ab-3cfcac9b0c3mr90009275ab.8.1737945715505;
        Sun, 26 Jan 2025 18:41:55 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH8Q1FmGSu72Xme2LzpIpIXDynnLEEWlYzx82fCsvTTJjOgUQJ24PhHCUXK4zXE1Zv57+di2qSut3EekkWTj/w=
X-Received: by 2002:a92:cd85:0:b0:3cf:cac9:b02d with SMTP id
 e9e14a558f8ab-3cfcac9b0c3mr90009175ab.8.1737945715156; Sun, 26 Jan 2025
 18:41:55 -0800 (PST)
MIME-Version: 1.0
References: <Z4WFjBVHpndct7br@desktop0a> <Z5bx7ZHNcyc5fM_L@darkstar.users.ipa.redhat.com>
In-Reply-To: <Z5bx7ZHNcyc5fM_L@darkstar.users.ipa.redhat.com>
From: Dave Young <dyoung@redhat.com>
Date: Mon, 27 Jan 2025 10:42:03 +0800
X-Gm-Features: AWEUYZmtM4UKBx7PMPjJ-FsuVERxuIkxYTcQ_FmWHvWjtRfiIWfQiv_6V0kI0nw
Message-ID: <CALu+AoSSKh=5ELgQyzDrGEDm5fm2XKteH1ZC70mm89pNSSPMHw@mail.gmail.com>
Subject: Re: [REGRESSION] Kernel booted via kexec fails to resume from hibernation
To: Roberto Ricci <io@r-ricci.it>
Cc: ebiederm@xmission.com, rafael@kernel.org, pavel@ucw.cz, ytcoode@gmail.com, 
	kexec@lists.infradead.org, linux-pm@vger.kernel.org, 
	akpm@linux-foundation.org, regressions@lists.linux.dev, 
	linux-kernel@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: -dEU8dBKJ-vFz1Mk49J8Zv1x_z8_QrZmQtTC1jwwo0E_1737945715
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250126_184159_696914_BEB01C9B 
X-CRM114-Status: GOOD (  20.21  )
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

On Mon, 27 Jan 2025 at 10:39, Dave Young <dyoung@redhat.com> wrote:
>
> Hi
> On 01/13/25 at 10:28pm, Roberto Ricci wrote:
> > After rebooting the system via kexec, hibernating and rebooting the machine, this oops occurs:
> >
> [snip]
> >
> > I will send the kernel config and dmesg in replies to this email.
> >
>
> I tried your config (removed some config driver related which is not useful), but it can not boot on my kvm guest.
> Firstly I saw a panic in ftrace path,  then I rebuilt the kernel without ftrace, it panicked again but in kvm related code path.
> Both are not related to kexec at all so I suspect your bug is not kexec specific.
>
> Ftrace panic:
> ----
>     0.215515] software IO TLB: area num 4.
> [    0.298815] SLUB: HWalign=64, Order=0-3, MinObjects=0, CPUs=4, Nodes=1
> Poking KASLR using RDRAND RDTSC...
> [    0.299813] ftrace: allocating 40381 entries in 158 pages
> [    0.300603] Oops: general protection fault, probably for non-canonical address 0xdffffc0000008a30: 0000 [#1] PREEMPT SMP KASAN NOPTI
> [    0.301877] KASAN: probably user-memory-access in range [0x0000000000045180-0x0000000000045187]
> [    0.302734] CPU: 0 UID: 0 PID: 0 Comm: swapper Not tainted 6.13.0_ricci+ #913
> [    0.303401] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-2.fc40 04/01/2014
> [    0.304187] RIP: 0010:__text_poke+0x370/0x840
> [    0.304591] Code: c6 48 8b 04 24 48 8d 78 08 e8 cc fb ff ff 48 c7 c0 80 51 04 00 48 8b 0d 96 32 d9 02 48 ba 00 00 00 00 00 fc ff df 48 c1 e8 03 <0f> b6 04 10 84 c0 74 06 0f 8e cc 03 00 00 65 0f b6 1d aa 3c ed 6e
> [    0.306646] RSP: 0000:ffffffff94007d88 EFLAGS: 00010006
> [    0.307139] RAX: 0000000000008a30 RBX: ffffffff93f0e070 RCX: ffff8881000744c0
> [    0.307839] RDX: dffffc0000000000 RSI: 8000000072001063 RDI: ffff88810006d0d8
> [    0.308634] RBP: ffffffff91001b24 R08: 0000000000000001 R09: fffffbfff2800f91
> [    0.309359] R10: 0000000000000003 R11: 0000000000000100 R12: 0000000000000005
> [    0.309994] R13: 0000000000000b24 R14: 0000000000000b29 R15: 8000000000000063
> [    0.310631] FS:  0000000000000000(0000) GS:ffff88815b400000(0000) knlGS:0000000000000000
> [    0.311351] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [    0.311867] CR2: ffff88817ffff000 CR3: 0000000075070001 CR4: 00000000000200b0
> [    0.312510] Call Trace:
> [    0.312731]  <TASK>
> [    0.312922]  ? __die_body.cold+0x19/0x2b
> [    0.313280]  ? die_addr+0x46/0x70
> [    0.313582]  ? exc_general_protection+0x150/0x240
> [    0.314010]  ? asm_exc_general_protection+0x26/0x30
> [    0.314454]  ? trace_initcall_start_cb+0x4/0x90
> [    0.314868]  ? __text_poke+0x370/0x840
> [    0.315211]  ? __text_poke+0x2ab/0x840
> [    0.315552]  ? __pfx_text_poke_memcpy+0x10/0x10
> [    0.315965]  ? __pfx___text_poke+0x10/0x10
> [    0.316345]  ? mutex_lock+0x87/0xe0
> [    0.316662]  ? __pfx_mutex_lock+0x10/0x10
> [    0.317096]  ? ftrace_now+0xc0/0xd0
> [    0.317431]  ? __pfx_ftrace_now+0x10/0x10
> [    0.317813]  ? trace_initcall_start_cb+0x4/0x90
> [    0.318245]  ftrace_modify_code_direct+0x58/0x70
> [    0.318696]  ftrace_process_locs+0x514/0xb70
> [    0.319105]  ftrace_init+0x80/0x150
> [    0.319458]  start_kernel+0x181/0x3c0
> [    0.319802]  x86_64_start_reservations+0x24/0x30
> [    0.320219]  x86_64_start_kernel+0x84/0x90
> [    0.320584]  common_startup_64+0x13e/0x141
> [    0.320952]  </TASK>
> [    0.321149] Modules linked in:
> [    0.321423] ---[ end trace 0000000000000000 ]---
> [    0.321832] RIP: 0010:__text_poke+0x370/0x840
> [    0.322227] Code: c6 48 8b 04 24 48 8d 78 08 e8 cc fb ff ff 48 c7 c0 80 51 04 00 48 8b 0d 96 32 d9 02 48 ba 00 00 00 00 00 fc ff df 48 c1 e8 03 <0f> b6 04 10 84 c0 74 06 0f 8e cc 03 00 00 65 0f b6 1d aa 3c ed 6e
> [    0.323906] RSP: 0000:ffffffff94007d88 EFLAGS: 00010006
> [    0.324383] RAX: 0000000000008a30 RBX: ffffffff93f0e070 RCX: ffff8881000744c0
> [    0.325025] RDX: dffffc0000000000 RSI: 8000000072001063 RDI: ffff88810006d0d8
> [    0.325681] RBP: ffffffff91001b24 R08: 0000000000000001 R09: fffffbfff2800f91
> [    0.326332] R10: 0000000000000003 R11: 0000000000000100 R12: 0000000000000005
> [    0.326986] R13: 0000000000000b24 R14: 0000000000000b29 R15: 8000000000000063
> [    0.327658] FS:  0000000000000000(0000) GS:ffff88815b400000(0000) knlGS:0000000000000000
> [    0.328411] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [    0.328931] CR2: ffff88817ffff000 CR3: 0000000075070001 CR4: 00000000000200b0
> [    0.329595] Kernel panic - not syncing: Attempted to kill the idle task!
> [    0.330278] ---[ end Kernel panic - not syncing: Attempted to kill the idle task! ]---
>
> kvm panic:
> -------
> [    0.222231] rcu: srcu_init: Setting srcu_struct sizes based on contention.
> [    0.222824] kfence: initialized - using 2097152 bytes for 255 objects at 0x(____ptrval____)-0x(____ptrval____)
> [    0.223470] Oops: general protection fault, probably for non-canonical address 0xdffffc0000005356: 0000 [#1] PREEMPT SMP KASAN NOPTI
> [    0.224200] KASAN: probably user-memory-access in range [0x0000000000029ab0-0x0000000000029ab7]
> [    0.224747] CPU: 0 UID: 0 PID: 0 Comm: swapper/0 Not tainted 6.13.0_ricci+ #917
> [    0.225223] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-2.fc40 04/01/2014
> [    0.225779] RIP: 0010:__sysvec_kvm_asyncpf_interrupt+0x64/0x110
> [    0.226169] Code: 7c e4 4a 48 c7 c7 40 35 27 b7 e8 67 c2 cd 01 48 c7 c0 b0 9a 02 00 48 ba 00 00 00 00 00 fc ff df 48 89 c1 83 e0 07 48 c1 e9 03 <0f> b6 14 11 38 c2 7f 08 84 d2 0f 85 80 00 00 00 65 0f b6 1d 54 61
> [    0.227327] RSP: 0000:ffff888157009fe0 EFLAGS: 00010006
> [    0.227657] RAX: 0000000000000000 RBX: ffffffffb7a07e68 RCX: 0000000000005356
> [    0.228088] RDX: dffffc0000000000 RSI: ffffffffb7273540 RDI: ffffffffb740be40
> [    0.228523] RBP: 0000000000000000 R08: 0000000000000001 R09: ffffed102ae07c08
> [    0.228960] R10: ffff88815703e047 R11: ffff888157009ff8 R12: 0000000000000000
> [    0.229390] R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
> [    0.229848] FS:  0000000000000000(0000) GS:ffff888157000000(0000) knlGS:0000000000000000
> [    0.230375] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [    0.231089] CR2: ffff88815d201000 CR3: 000000015ba66001 CR4: 00000000000200b0
> [    0.231567] Call Trace:
> [    0.231727]  <IRQ>
> [    0.231859]  ? __die_body.cold+0x19/0x26
> [    0.232125]  ? die_addr+0x41/0x70
> [    0.232354]  ? exc_general_protection+0x150/0x240
> [    0.232663]  ? asm_exc_general_protection+0x26/0x30
> [    0.232988]  ? __sysvec_kvm_asyncpf_interrupt+0x64/0x110
> [    0.233341]  sysvec_kvm_asyncpf_interrupt+0x9b/0xe0
> [    0.233668]  </IRQ>
> [    0.233805]  <TASK>
> [    0.233942]  asm_sysvec_kvm_asyncpf_interrupt+0x1a/0x20
> [    0.234295] RIP: 0010:__x86_return_thunk+0x0/0x10
> [    0.234606] Code: 01 00 00 00 cc e8 01 00 00 00 cc 48 81 c4 80 00 00 00 65 48 c7 05 3c 54 14 49 ff ff ff ff c3 cc 66 2e 0f 1f 84 00 00 00 00 00 <c3> 90 90 90 90 cc cc cc cc cc cc cc cc cc cc cc e9 eb ff ff ff 0f
> [    0.235828] RSP: 0000:ffffffffb7a07f18 EFLAGS: 00000296
> [    0.236168] RAX: 0000000000000096 RBX: 0000000000000000 RCX: 1ffff1102ae07af0
> [    0.236677] RDX: dffffc0000000000 RSI: 0000000000000004 RDI: 000000000000000f
> [    0.237148] RBP: 00000000000000b0 R08: 0000000000000001 R09: 0000000000000000
> [    0.237610] R10: ffff8881571c1e40 R11: 0000000000000007 R12: 0000000000000000
> [    0.238071] R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000094770
> [    0.238547]  start_kernel+0x263/0x3a0
> [    0.238787]  x86_64_start_reservations+0x24/0x30
> [    0.239088]  x86_64_start_kernel+0x84/0x90
> [    0.239355]  common_startup_64+0x13e/0x141
> [    0.239637]  </TASK>
> [    0.239786] Modules linked in:
> [    0.239987] ---[ end trace 0000000000000000 ]---
> [    0.240287] RIP: 0010:__sysvec_kvm_asyncpf_interrupt+0x64/0x110
> [    0.240676] Code: 7c e4 4a 48 c7 c7 40 35 27 b7 e8 67 c2 cd 01 48 c7 c0 b0 9a 02 00 48 ba 00 00 00 00 00 fc ff df 48 89 c1 83 e0 07 48 c1 e9 03 <0f> b6 14 11 38 c2 7f 08 84 d2 0f 85 80 00 00 00 65 0f b6 1d 54 61
> [    0.241896] RSP: 0000:ffff888157009fe0 EFLAGS: 00010006
> [    0.242242] RAX: 0000000000000000 RBX: ffffffffb7a07e68 RCX: 0000000000005356
> [    0.242708] RDX: dffffc0000000000 RSI: ffffffffb7273540 RDI: ffffffffb740be40
> [    0.243194] RBP: 0000000000000000 R08: 0000000000000001 R09: ffffed102ae07c08
> [    0.243659] R10: ffff88815703e047 R11: ffff888157009ff8 R12: 0000000000000000
> [    0.244122] R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
> [    0.244595] FS:  0000000000000000(0000) GS:ffff888157000000(0000) knlGS:0000000000000000
> [    0.245121] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [    0.245502] CR2: ffff88815d201000 CR3: 000000015ba66001 CR4: 00000000000200b0
> [    0.245968] Kernel panic - not syncing: Fatal exception in interrupt
> [    0.246411] ---[ end Kernel panic - not syncing: Fatal exception in interrupt ]---
>
>
> You can find the kernel config here (with the ftrace enabled):
> https://people.redhat.com/~ruyang/snakeyear/panic-ftrace.config

BTW, if I disable KASAN then kernel can boot, anyway kexec +
hibernation works fine with a few tests, no panics.

>
> Thanks
> Dave
>


