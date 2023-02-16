Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A6CCC61DA4
	for <kexec@archiver.kernel.org>; Thu, 16 Feb 2023 18:12:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=QX4dpSgBKjnEYP4mMLbR+P9/qaiEIYE80JbE2Qj8rTA=; b=nC1Pfn2/tTW6TO
	bh9+ipbKtgH9+Uwvb/sti9CxikDWU1TtnXu1aNYk47A5kjtxPK2sHA40xfSdtZPeGcb6tKq3pTLDl
	a3PmLMQ7l4+RW9IrRaOGlA+E2f5bXsjYTh4LUNkume8gHQnwaubelBl01ZuZGmROsKWBQXyxu7qRu
	+STbCloRilkoOEfXRy/YKjV+GK4vEzlG2nF2KD41zrQppvB0cZDP/RKUjObql907R3ywernZ/2jhT
	qnmUszmNSSeKJADsZaB67PLxXvC/BXJ+EskR079mDF9tkQmIQpIUdMLK6Xti1Q8scY7db6pARLX6Z
	jzjufORa02daXNlQpTdw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pSikN-00BSEc-OS; Thu, 16 Feb 2023 18:12:43 +0000
Received: from out2-smtp.messagingengine.com ([66.111.4.26])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pSikL-00BSC4-JN
	for kexec@lists.infradead.org; Thu, 16 Feb 2023 18:12:42 +0000
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailout.nyi.internal (Postfix) with ESMTP id 2E4A35C010D;
	Thu, 16 Feb 2023 13:12:35 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Thu, 16 Feb 2023 13:12:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shutemov.name;
	 h=cc:cc:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:sender
	:subject:subject:to:to; s=fm2; t=1676571155; x=1676657555; bh=bS
	ftew9gDz0nxHH+J/ZHM8BKvNdoOfwEqV6015Wt6UM=; b=U5UKHZUQDc1987amT/
	6c7+8Je0d8GW+Gf4YZipuK0UHqck2Q4Nw9wZo/0HXhJle83a27m0dKX4gOUipn/Y
	19BNTRmwdflnQ+gJnyZuu3CjUeLIdVBenCyn4qpN8cTIj9X5X4NxUtFVIkKwwvOf
	xU9cF4WdzSgiT2oPJa4pnYANuGCmdhu3uSEqDWw23UsA/rEJ8YkBu8GRdwJBzTSj
	kRk6QOT0rUUGfSird8dvn7MJxpQ/iGRAooiCnVjX+A+EubadC1DBGfgj4muoD/Db
	wPRZyl6vyI5ba3pSTUVPx3/G5m1epxKjDUjxI4ZfvkRvKZKyk80tMo0QAtN5i4n8
	4oMQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
	:feedback-id:from:from:in-reply-to:in-reply-to:message-id
	:mime-version:references:reply-to:sender:subject:subject:to:to
	:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1676571155; x=1676657555; bh=bSftew9gDz0nxHH+J/ZHM8BKvNdo
	OfwEqV6015Wt6UM=; b=Ho955abK3qFL6x04/8LI7suHmH9zzr19Bnf5ALDQsSbv
	MzkIQXKf54e/1yiNW7QbqvcLPJHGZ91Q439eWrkDmK7neRquyWiabXsnF03y3kmW
	hLyQympzdXeJSRKr3/HLT2D1c6s3Anpp5L9IemqBs1bd3SqKOhVQQMJSApmPZ3/9
	Hf+AUrmWWB1nkA2BFBgG9B1ieRL34RoVpBm2+jK1e0v+8p70ZSTlgMuQIL6DcAaL
	9X2pvATHQnBjt90mDLdGmi0Qq++xJrGyDhyf1WDvKK+DPYxnNfrKcoT+rlejt0z+
	rsZ/kfR5XwcrKM+39lAjURnf+0/W3HJ3gYrzo3+S2w==
X-ME-Sender: <xms:EnLuY559I808bVSgLnAVcgGda9J0JuKDqXPqN1UeSKY2msP9CD35dQ>
    <xme:EnLuY26MllRHNLn5nZNAk5YdlLPIKqSacUHL-cEzgTjmez8Z5RfAxXhiaw2LGed1R
    Fl3HilEzkDb94zagb8>
X-ME-Received: <xmr:EnLuYwf3DBc07x7gYwxeTlPgIVbKtKVKU7faZjXO2tfeXVyVOm5p3O4k5zg7AVVs9jW_-w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrudeijedguddtkecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehttddttddttddvnecuhfhrohhmpedfmfhi
    rhhilhhlucetrdcuufhhuhhtvghmohhvfdcuoehkihhrihhllhesshhhuhhtvghmohhvrd
    hnrghmvgeqnecuggftrfgrthhtvghrnhephfeigefhtdefhedtfedthefghedutddvueeh
    tedttdehjeeukeejgeeuiedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepkhhirhhilhhlsehshhhuthgvmhhovhdrnhgrmhgv
X-ME-Proxy: <xmx:EnLuYyLkzIfUk2BTS24GveS4bqgd-S6FyXnAYRvK6M4OKHRKLEgF0g>
    <xmx:EnLuY9Jyz-4x5BdbtIT8aRIuFXZmiT2MSe_SK-X1Ypa6hDfXk1uD5g>
    <xmx:EnLuY7wr-4VBeYZ4QVmf1WrR-O86mvd1e8POtbrBdCvgHtE44N1EIQ>
    <xmx:E3LuY0-vE7s97im3M9fHEI1v4JUsa5g3Zuh-Srhg63_CiARFx0AJTw>
Feedback-ID: ie3994620:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 16 Feb 2023 13:12:34 -0500 (EST)
Received: by box.shutemov.name (Postfix, from userid 1000)
	id 3D2E110968A; Thu, 16 Feb 2023 21:12:30 +0300 (+03)
Date: Thu, 16 Feb 2023 21:12:30 +0300
From: "Kirill A. Shutemov" <kirill@shutemov.name>
To: Dave Hansen <dave.hansen@intel.com>
Cc: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
	Borislav Petkov <bp@alien8.de>,
	Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Isaku Yamahata <isaku.yamahata@intel.com>, x86@kernel.org,
	linux-coco@lists.linux.dev, kexec@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] Kexec enabling in TDX guest
Message-ID: <20230216181230.3jn5hebv3xkdivbx@box.shutemov.name>
References: <20230213234836.3683-1-kirill.shutemov@linux.intel.com>
 <65fc95bb-5ad9-b589-d6a4-762289b3f6bc@intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <65fc95bb-5ad9-b589-d6a4-762289b3f6bc@intel.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230216_101241_729435_3F1A5C60 
X-CRM114-Status: GOOD (  12.58  )
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

On Thu, Feb 16, 2023 at 09:50:32AM -0800, Dave Hansen wrote:
> On 2/13/23 15:48, Kirill A. Shutemov wrote:
> > The patch brings basic enabling of kexec in TDX guests.
> > 
> > By "basic enabling" I mean, kexec in the guests with a single CPU.
> > TDX guests use ACPI MADT MPWK to bring up secondary CPUs. The mechanism
> > doesn't allow to put a CPU back offline if it has woken up.
> > 
> > We are looking into this, but it might take time.
> 
> This is simple enough.  But, nobody will _actually_ use this code as-is,
> right?  What's the point of applying it now?

Why nobody? Single CPU VMs are not that uncommon.

-- 
  Kiryl Shutsemau / Kirill A. Shutemov

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
