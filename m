Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D31ACC25B74
	for <kexec@archiver.kernel.org>; Fri, 24 May 2024 15:27:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=wbmjo0zXpJShHnv5XrZBPVxC5I1tHcWMUkcJ8vOF+Ys=; b=rfILPi4/gj1ibJ
	7ERzftMDMeyhzkpCcvZFBMvB39KOkSu8XW0vPhQRkJtRGcAmsZawIgUUzS7FfZppgz4sTMH/xexf+
	olth5kenrJQVSILR49wyBpmMFPvcfaHFubrgdZoBOLaTVBZkNGHgZbGzCW2SmfNBjNmd0qvQCcPVc
	gCHaxkRLiVVvVpMW55x9IZZ/D3+1zN2U/SVPSSpDiDrHgaJu4sdbHIy0X2vWahM9WtuvBWxNvXwOk
	l0GngO4E7NMbX2CmycyqnqwtKol1rJD9cbpWpRuumiG1s2UTAPc5QTtxcFV7DfSKZyldzKNsIoppS
	Kzo/unfEns+GiFQbbBag==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sAWpe-00000009EkB-2KAW;
	Fri, 24 May 2024 15:27:46 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sAWpb-00000009Ejc-3HjL
	for kexec@lists.infradead.org;
	Fri, 24 May 2024 15:27:45 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id E046362E59;
	Fri, 24 May 2024 15:27:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2D2FC2BBFC;
	Fri, 24 May 2024 15:27:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1716564462;
	bh=EWjF42HyXFIgPE/ta6fPNwbxqec2D+5L3iGHiCR4VVE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ySVIarrIR6ZWmjPpQVVQ9tWKvUgXSa6m1ze/sqoVetRaVplOtZC/3uK+7FFWyCtmu
	 tHdk1KijyfvxBZx0nonTxR8+lddXEXVXPa1RjyMy66uQiXI+TThy/cnhT/ux+zW1YS
	 XXBmXfuFAYjKCXx0bObb7N7LcHSo/fBkpyA7yWC8=
Date: Fri, 24 May 2024 17:27:39 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Jiri Bohac <jbohac@suse.cz>
Cc: cve@kernel.org, linux-kernel@vger.kernel.org,
	linux-cve-announce@vger.kernel.org,
	Eric Biederman <ebiederm@xmission.com>, kexec@lists.infradead.org
Subject: Re: CVE-2023-52823: kernel: kexec: copy user-array safely
Message-ID: <2024052431-decline-limes-da66@gregkh>
References: <2024052106-CVE-2023-52823-3d81@gregkh>
 <ZlBlorsBMPK0RdnR@dwarf.suse.cz>
 <2024052420-clang-flatterer-366b@gregkh>
 <ZlCKLBjrF5PWt1hz@dwarf.suse.cz>
 <ZlCgoTr27AT_eg9A@dwarf.suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <ZlCgoTr27AT_eg9A@dwarf.suse.cz>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240524_082743_966918_91A51D7D 
X-CRM114-Status: GOOD (  10.45  )
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

On Fri, May 24, 2024 at 04:13:53PM +0200, Jiri Bohac wrote:
> On Fri, May 24, 2024 at 02:38:04PM +0200, Jiri Bohac wrote:
> > On Fri, May 24, 2024 at 12:15:47PM +0200, Greg Kroah-Hartman wrote:
> > > Nice, but then why was this commit worded this way?  Now we check twice?
> > > Double safe?  Should it be reverted?
> > 
> > double safe's good; turning it into a CVE not so much :(
> > CVE-2023-52822, CVE-2023-52824 and CVE-2023-52820, originally from the same patch
> > series, seem to be the exact same case.
> 
> Same thing: CVE-2023-52758

Agreed, now rejected, thanks for the review!

greg k-h

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
