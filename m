Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08AF9D3C542
	for <kexec@archiver.kernel.org>; Fri, 18 Oct 2024 02:19:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=DZN7OJ+hhe6dSanQVptke4JFwpR4+3WB7u/xANBxEKA=; b=GnDC6cz/+Zb3RC
	7xPti1g4qN35giX3xAmzLGC6GuDcUMiMMAFGx7BXt4hyHa5h21bVwh0OC7uEhB9qi679rzO3XjWQN
	8/BvzyPqFcsb0O8Ryt5UOfd5L7xosxPPiclvKoTjdO+/Ze+yCFj59XFlyeaXaxp99Ht2QfB51reys
	j+SimmHyEYNAXU+Ljd7w8HM78Z251F/6Xb2Z6sF3AShAKOKQt4Pz9ftvBG01oI7YDzv6zlFRmjLkM
	uTQh/X4qINBcqMNZ03w07HV/kqg1pjiWul3Ik+DDEAK/JVsQaC/JqfNwnCHQU+xXF+0FsocfLtlFG
	UDZENTW2Dury3/q8XIjg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t1cZw-0000000Ge3W-1Rc1;
	Fri, 18 Oct 2024 02:19:00 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t1cZt-0000000Ge2t-2QwC
	for kexec@lists.infradead.org;
	Fri, 18 Oct 2024 02:18:59 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1729217935;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=YfvFw0tOK2Fyk1UbczyrvNOBcIGyduZmN7lJxbAzLyg=;
	b=DsAUwdjBrM3r+VeaZgxxWhxjBxPq8hRLoGjQzLPY8Zm81aP88/CwjRT8Ftj8fkUPfYeo/3
	LQunZS1Gxmsu7jprhDPCyLJKhsy7Cy4hThGVUcd/R//nPQaNzs/rJ08m9w3J7cOMHNH8Ro
	lXtKkjG73bTg+q89Tk09qLBz2ma76Os=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-614-5A-PiV4VMYyr7Pcz-3CGkw-1; Thu,
 17 Oct 2024 22:18:53 -0400
X-MC-Unique: 5A-PiV4VMYyr7Pcz-3CGkw-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 5ECAE1955F41;
	Fri, 18 Oct 2024 02:18:51 +0000 (UTC)
Received: from localhost (unknown [10.72.112.28])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 6861619560A3;
	Fri, 18 Oct 2024 02:18:48 +0000 (UTC)
Date: Fri, 18 Oct 2024 10:18:42 +0800
From: Baoquan He <bhe@redhat.com>
To: Gregory Price <gourry@gourry.net>
Cc: kexec@lists.infradead.org, linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org, bhelgaas@google.com,
	andriy.shevchenko@linux.intel.com, ilpo.jarvinen@linux.intel.com,
	mika.westerberg@linux.intel.com, ying.huang@intel.com,
	tglx@linutronix.de, takahiro.akashi@linaro.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] resource,kexec: walk_system_ram_res_rev must retain
 resource flags
Message-ID: <ZxHFgmHPe3Cow2n8@MiWiFi-R3L-srv>
References: <20241017190347.5578-1-gourry@gourry.net>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20241017190347.5578-1-gourry@gourry.net>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241017_191857_715873_D40C08B8 
X-CRM114-Status: GOOD (  19.69  )
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

HI Gregory,

On 10/17/24 at 03:03pm, Gregory Price wrote:
> walk_system_ram_res_rev() erroneously discards resource flags when
> passing the information to the callback.
> 
> This causes systems with IORESOURCE_SYSRAM_DRIVER_MANAGED memory to
> have these resources selected during kexec to store kexec buffers
> if that memory happens to be at placed above normal system ram.

Sorry about that. I haven't checked IORESOURCE_SYSRAM_DRIVER_MANAGED
memory carefully, wondering if res could be set as
'IORESOURCE_SYSTEM_RAM | IORESOURCE_BUSY' plus
IORESOURCE_SYSRAM_DRIVER_MANAGED in iomem_resource tree.

Anyway, the change in this patch is certainly better. Thanks.

Acked-by: Baoquan He <bhe@redhat.com>

> 
> This leads to undefined behavior after reboot. If the kexec buffer
> is never touched, nothing happens. If the kexec buffer is touched,
> it could lead to a crash (like below) or undefined behavior.
> 
> Tested on a system with CXL memory expanders with driver managed
> memory, TPM enabled, and CONFIG_IMA_KEXEC=y. Adding printk's
> showed the flags were being discarded and as a result the check
> for IORESOURCE_SYSRAM_DRIVER_MANAGED passes.
> 
> find_next_iomem_res: name(System RAM (kmem))
> 		     start(10000000000)
> 		     end(1034fffffff)
> 		     flags(83000200)
> 
> locate_mem_hole_top_down: start(10000000000) end(1034fffffff) flags(0)
> 
> [.] BUG: unable to handle page fault for address: ffff89834ffff000
> [.] #PF: supervisor read access in kernel mode
> [.] #PF: error_code(0x0000) - not-present page
> [.] PGD c04c8bf067 P4D c04c8bf067 PUD c04c8be067 PMD 0
> [.] Oops: 0000 [#1] SMP
> [.] RIP: 0010:ima_restore_measurement_list+0x95/0x4b0
> [.] RSP: 0018:ffffc900000d3a80 EFLAGS: 00010286
> [.] RAX: 0000000000001000 RBX: 0000000000000000 RCX: ffff89834ffff000
> [.] RDX: 0000000000000018 RSI: ffff89834ffff000 RDI: ffff89834ffff018
> [.] RBP: ffffc900000d3ba0 R08: 0000000000000020 R09: ffff888132b8a900
> [.] R10: 4000000000000000 R11: 000000003a616d69 R12: 0000000000000000
> [.] R13: ffffffff8404ac28 R14: 0000000000000000 R15: ffff89834ffff000
> [.] FS:  0000000000000000(0000) GS:ffff893d44640000(0000) knlGS:0000000000000000
> [.] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [.] ata5: SATA link down (SStatus 0 SControl 300)
> [.] CR2: ffff89834ffff000 CR3: 000001034d00f001 CR4: 0000000000770ef0
> [.] PKRU: 55555554
> [.] Call Trace:
> [.]  <TASK>
> [.]  ? __die+0x78/0xc0
> [.]  ? page_fault_oops+0x2a8/0x3a0
> [.]  ? exc_page_fault+0x84/0x130
> [.]  ? asm_exc_page_fault+0x22/0x30
> [.]  ? ima_restore_measurement_list+0x95/0x4b0
> [.]  ? template_desc_init_fields+0x317/0x410
> [.]  ? crypto_alloc_tfm_node+0x9c/0xc0
> [.]  ? init_ima_lsm+0x30/0x30
> [.]  ima_load_kexec_buffer+0x72/0xa0
> [.]  ima_init+0x44/0xa0
> [.]  __initstub__kmod_ima__373_1201_init_ima7+0x1e/0xb0
> [.]  ? init_ima_lsm+0x30/0x30
> [.]  do_one_initcall+0xad/0x200
> [.]  ? idr_alloc_cyclic+0xaa/0x110
> [.]  ? new_slab+0x12c/0x420
> [.]  ? new_slab+0x12c/0x420
> [.]  ? number+0x12a/0x430
> [.]  ? sysvec_apic_timer_interrupt+0xa/0x80
> [.]  ? asm_sysvec_apic_timer_interrupt+0x16/0x20
> [.]  ? parse_args+0xd4/0x380
> [.]  ? parse_args+0x14b/0x380
> [.]  kernel_init_freeable+0x1c1/0x2b0
> [.]  ? rest_init+0xb0/0xb0
> [.]  kernel_init+0x16/0x1a0
> [.]  ret_from_fork+0x2f/0x40
> [.]  ? rest_init+0xb0/0xb0
> [.]  ret_from_fork_asm+0x11/0x20
> [.]  </TASK>
> 
> Link: https://lore.kernel.org/all/20231114091658.228030-1-bhe@redhat.com/
> Fixes: 7acf164b259d ("resource: add walk_system_ram_res_rev()")
> Cc: stable@vger.kernel.org
> Signed-off-by: Gregory Price <gourry@gourry.net>
> ---
>  kernel/resource.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/kernel/resource.c b/kernel/resource.c
> index b730bd28b422..4101016e8b20 100644
> --- a/kernel/resource.c
> +++ b/kernel/resource.c
> @@ -459,9 +459,7 @@ int walk_system_ram_res_rev(u64 start, u64 end, void *arg,
>  			rams_size += 16;
>  		}
>  
> -		rams[i].start = res.start;
> -		rams[i++].end = res.end;
> -
> +		rams[i++] = res;
>  		start = res.end + 1;
>  	}
>  
> -- 
> 2.43.0
> 


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
