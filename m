Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3055C433FE
	for <kexec@archiver.kernel.org>; Fri, 14 Oct 2022 16:29:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=dUr9jCUwQQd5ZAap8HJonC/6Uc8dMnTpSqR0ThB2KgY=; b=QQ3C1u9kgzPNO2
	0l3BPmCmJpf4jFRNZs2XYk4y6VjDFaINN2nT26SLLsqQVr8Vt3awWuvOK1kuOiaPrLUtjrI3bJ7+B
	/E0uvlffH0YnDXObQZcI+Jr4qYWpEESCL1r2xZmWOkMCoS0eIuA56M0H+KF7O03DEFZ2y589jSDb7
	3UaPOC3QebfRDsTsuWP5RBT7lNuvhfuUQgBhxGssyT8QNWZkdGR4qUycDSk4nOvW0f40sWu+WYy3Y
	Rf+ihGW2pJthQkrIB8eb99+LzEdPjW5SLmhaCDFyPliE6rw/hC1Z3aXv+nYpcm2CEOmcdl4RzDhBe
	xWceUVSGgCg/r54RwqeA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ojNZE-00FLUv-3F; Fri, 14 Oct 2022 16:29:48 +0000
Received: from ams.source.kernel.org ([2604:1380:4601:e00::1])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ojNZB-00FLSj-9f; Fri, 14 Oct 2022 16:29:46 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.source.kernel.org (Postfix) with ESMTPS id 74C39B82370;
	Fri, 14 Oct 2022 16:29:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 264EDC433D6;
	Fri, 14 Oct 2022 16:29:31 +0000 (UTC)
Date: Fri, 14 Oct 2022 17:29:28 +0100
From: Catalin Marinas <catalin.marinas@arm.com>
To: Baoquan He <bhe@redhat.com>
Cc: john.p.donnelly@oracle.com, Will Deacon <will@kernel.org>,
	"Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>,
	Dave Young <dyoung@redhat.com>, Vivek Goyal <vgoyal@redhat.com>,
	kexec@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
	"Eric W . Biederman" <ebiederm@xmission.com>,
	Randy Dunlap <rdunlap@infradead.org>,
	Feng Zhou <zhoufeng.zf@bytedance.com>,
	Kefeng Wang <wangkefeng.wang@huawei.com>,
	Chen Zhou <dingguo.cz@antgroup.com>,
	Dave Kleikamp <dave.kleikamp@oracle.com>,
	"samasth.norway.ananda" <samasth.norway.ananda@oracle.com>
Subject: Re: [PATCH v3 0/2] arm64: kdump: Function supplement and performance
 optimization
Message-ID: <Y0mOaLL6wO2Mp7dy@arm.com>
References: <20220711090319.1604-1-thunder.leizhen@huawei.com>
 <YueMyUqannVg7l9v@MiWiFi-R3L-srv>
 <a80c2b7e-a510-8e45-1f3c-7e2ddf79bc37@huawei.com>
 <1d89e2cb-de26-0f85-7a2a-f68599a1b143@oracle.com>
 <Y0fsi4+T6k/OO0hx@MiWiFi-R3L-srv>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <Y0fsi4+T6k/OO0hx@MiWiFi-R3L-srv>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221014_092945_498186_79C80B34 
X-CRM114-Status: GOOD (  15.47  )
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

On Thu, Oct 13, 2022 at 06:46:35PM +0800, Baoquan He wrote:
> On 10/06/22 at 09:55am, john.p.donnelly@oracle.com wrote:
> > What is the progress of this series ?
> > 
> > Without this patch set we are seeing  larger crashkernel=896M failures on
> > Arm  with Linux-6.0.rc7.  This larger value is needed for
> > iSCSI booted systems with certain network adapters.
> 
> This change is located in arch/arm64 folder, I have pinged arm64
> maintainer to consider merging this patchset. Not sure if they are
> still thinking, or ignore this.
> 
> Hi Catalin, Will,
> 
> Ping again!
> 
> Do you have plan to accept this patchset? It's very important for
> crashkernel setting on arm64 with a simple and default syntax.

I'll look at it once the merging window closes. I saw discussions on
this thread and I ignored it until you all agreed ;).

-- 
Catalin

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
