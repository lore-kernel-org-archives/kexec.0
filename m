Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F82AC4332F
	for <kexec@archiver.kernel.org>; Tue, 14 Nov 2023 16:03:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Date:Cc:To:From:Subject:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=VazqwRNw1YK0DqXyFfYETc87q3XT8c4w0CFqeRldfZc=; b=QlB7dSS2ig/yTT
	LebVwvBet/8RVEs92Ho8gvqnkfiZfGCjQR6wS8JzI5N0fymq/sA67MG+DmUzD3KuihRkpsP5kqJ3W
	Q6z1FZlT1aXA6mPXH62q2rbkz57c8renQA3dL6EmR2nY1YwQ8h2v7zRh9rQE5H//M7EcuppcoJe0V
	Gtw2UVZYmpyVTX7ZItk69V3WljwE+GvhmeybmGLtpMqDmf7yXAky1qp10BVUItZcGC0ZtUfQrJpmB
	X6CS7/ugtClPpmqwI7S4172La/TpN+hMv9JdWUW+XKhI8GSo04VqxNHcdrAFr6pmGBKMQm332bjS0
	rnmySXVWLS96HLZRj6nw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1r2vt0-00GOBv-0D;
	Tue, 14 Nov 2023 16:03:34 +0000
Received: from smtprelay0011.hostedemail.com ([216.40.44.11] helo=relay.hostedemail.com)
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1r2vsx-00GOB4-1p;
	Tue, 14 Nov 2023 16:03:33 +0000
Received: from omf17.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay09.hostedemail.com (Postfix) with ESMTP id 5849480ADD;
	Tue, 14 Nov 2023 16:03:24 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf17.hostedemail.com (Postfix) with ESMTPA id B79FD17;
	Tue, 14 Nov 2023 16:03:19 +0000 (UTC)
Message-ID: <1e7863ec4e4ab10b84fd0e64f30f8464d2e484a3.camel@perches.com>
Subject: Re: [PATCH 1/7] kexec_file: add kexec_file flag to control debug
 printing
From: Joe Perches <joe@perches.com>
To: Baoquan He <bhe@redhat.com>, linux-kernel@vger.kernel.org
Cc: kexec@lists.infradead.org, x86@kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-riscv@lists.infradead.org, 
	linuxppc-dev@lists.ozlabs.org, linux-parisc@vger.kernel.org
Date: Tue, 14 Nov 2023 08:03:17 -0800
In-Reply-To: <20231114153253.241262-2-bhe@redhat.com>
References: <20231114153253.241262-1-bhe@redhat.com>
	 <20231114153253.241262-2-bhe@redhat.com>
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
X-Rspamd-Queue-Id: B79FD17
X-Rspamd-Server: rspamout06
X-Stat-Signature: hfguyu43qitk9i95uumxmjn7sq3qxaae
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX1+TPCSBX5eIBtFS7cutbFXyyoB+lO2Ea1A=
X-HE-Tag: 1699977799-197779
X-HE-Meta: U2FsdGVkX199MxvfdP2OiWMaMCgnF+zen3H+uDaMOt+eo18KFoigVkpo/j1mPnNdRxZsnaKbc/2TMWhhtZ1WYbE4xnaRnZ9D8ImVTw0nNbwHPVmM8K50LsJ54PlQr2IROfdWLMnnNPpRHRTXWI450/26vHlRs47bJHW69JfdozUlDgILIKSRfePjUbHAIXoIKr9/NzIpcA6QdsnzFrKhA8GVb/HExMWgTm+7q60/jyGC6TQFrwo3I1762UXDKC1ld2/TBOn7K4fNFKAezne04n/qoyaeJN2h75PDcDpXFrJm8izGV0wc97AWTmYxsKdc
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231114_080331_684091_5F191397 
X-CRM114-Status: GOOD (  16.18  )
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

On Tue, 2023-11-14 at 23:32 +0800, Baoquan He wrote:
> When specifying 'kexec -c -d', kexec_load interface will print loading
> information, e.g the regions where kernel/initrd/purgatory/cmdline
> are put, the memmap passed to 2nd kernel taken as system RAM ranges,
> and printing all contents of struct kexec_segment, etc. These are
> very helpful for analyzing or positioning what's happening when
> kexec/kdump itself failed. The debugging printing for kexec_load
> interface is made in user space utility kexec-tools.
> 
> Whereas, with kexec_file_load interface, 'kexec -s -d' print nothing.
> Because kexec_file code is mostly implemented in kernel space, and the
> debugging printing functionality is missed. It's not convenient when
> debugging kexec/kdump loading and jumping with kexec_file_load
> interface.
> 
> Now add KEXEC_FILE_DEBUG to kexec_file flag to control the debugging
> message printing. And add global variable kexec_file_dbg_print and
> macro kexec_dprintk() to facilitate the printing.
> 
> This is a preparation, later kexec_dprintk() will be used to replace the
> existing pr_debug(). Once 'kexec -s -d' is specified, it will print out
> kexec/kdump loading information. If '-d' is not specified, it regresses
> to pr_debug().

Not quite as pr_debug is completely eliminated with
zero object size when DEBUG is not #defined.

Now the object size will be larger and contain the
formats in .text.

[]
> diff --git a/include/linux/kexec.h b/include/linux/kexec.h
[]
> @@ -264,6 +264,18 @@ arch_kexec_apply_relocations(struct purgatory_info *pi, Elf_Shdr *section,
>  	return -ENOEXEC;
>  }
>  #endif
> +
> +extern bool kexec_file_dbg_print;
> +
> +#define kexec_dprintk(fmt, args...)			\
> +	do {						\
> +		if (kexec_file_dbg_print)		\
> +			printk(KERN_INFO fmt, ##args);	\
> +		else					\
> +			printk(KERN_DEBUG fmt, ##args);	\
> +	} while (0)
> +
> +

I don't know how many of these printks exist and if
overall object size matters but using

#define kexec_dprintkfmt, ...)					\
	printk("%s" fmt,					\
	       kexec_file_dbg_print ? KERN_INFO : KERN_DEBUG,	\
	       ##__VA_ARGS__)

should reduce overall object size by eliminating the
mostly duplicated format in .text which differs only
by the KERN_<PREFIX>



_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
