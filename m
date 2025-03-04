Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6312EC282D0
	for <kexec@archiver.kernel.org>; Tue,  4 Mar 2025 23:53:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Mime-Version:References:In-Reply-To:Message-Id:Subject:To:From:
	Date:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=DOZ+8wmkawd83rJK0gEScZPK76Inndki3s+Qh46ktp8=; b=j08JOxHpVskTJKc7YHN+OEwP08
	n7gMhVW5Li81njOo10kCR8Pw4++xE6AWgidFLFMKpLIqhDWnyOy98RnFBZy+P6dSparqBIYt2Ewf2
	H/hXO0DMhCBPtkVMsVg3n24uk5G7fdz+zXDj/7JpCO/JFX/z87ggEn+OsrVsBS/17PThzagDII6TF
	b/zCtv5BRB1Fd7PqmUcvPXSRIuhuiMIjD9XAQThU/3fu0joTSzc7Hp8eycmoA6Ds2B1Ge1T0xaKp8
	+MsmqUzAFNE72brusO7mt8aQMMyjRvDQQ35OLg/QUZ1vs8m+UmoRpHSBMaMDanZj6AHU+K2CdVfp5
	J8v8EI9A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tpc4q-00000006ZKc-3dNQ;
	Tue, 04 Mar 2025 23:53:32 +0000
Received: from nyc.source.kernel.org ([147.75.193.91])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tpc4o-00000006ZJm-0KWw
	for kexec@lists.infradead.org;
	Tue, 04 Mar 2025 23:53:31 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id 29AD2A46021;
	Tue,  4 Mar 2025 23:47:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 515A5C4CEE5;
	Tue,  4 Mar 2025 23:53:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1741132408;
	bh=q4ihMWeSDYGy90QmpRS0XEWYMYyxawUw1y5E7gZ+Sa8=;
	h=Date:From:To:Subject:In-Reply-To:References:From;
	b=wNRQrFVyFEe0fO6KvuTU05ovjEYjylU6yNMdXwoT+vAT1RwAeJwXDigVUNNXusFvB
	 vbifi5NzMjDZmdMxGVi6hlYr6QwGft/wuXUkjyqoE5jKIt5NwHmfPYOnG1N2zcC3aP
	 T86iJXnZMZq3K8txWYo6bmX1mK0QiOxhTGaXWyW4=
Date: Tue, 4 Mar 2025 15:53:27 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: Baoquan He <bhe@redhat.com>, "Kirill A. Shutemov"
 <kirill@shutemov.name>, ebiederm@xmission.com, kexec@lists.infradead.org,
 Yan Zhao <yan.y.zhao@intel.com>, linux-kernel@vger.kernel.org,
 linux-coco@lists.linux.dev, x86@kernel.org, rick.p.edgecombe@intel.com,
 kirill.shutemov@linux.intel.com
Subject: Re: [PATCH v2 0/1] Accept unaccepted kexec segments' destination
 addresses
Message-Id: <20250304155327.4499dcbbfa2445f76927c6c3@linux-foundation.org>
In-Reply-To: <20250304154353.a79c330bffb4d21dce2dad9c@linux-foundation.org>
References: <20241213094930.748-1-yan.y.zhao@intel.com>
	<xgycziy2o56hnom3oau7sbqed3meoni3razc6njj7ujatldnmm@s7odbl4splbn>
	<Z4T1G4dwzo7qdwSP@MiWiFi-R3L-srv>
	<20250304154353.a79c330bffb4d21dce2dad9c@linux-foundation.org>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250304_155330_191651_41995085 
X-CRM114-Status: GOOD (  20.69  )
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

On Tue, 4 Mar 2025 15:43:53 -0800 Andrew Morton <akpm@linux-foundation.org> wrote:

> On Mon, 13 Jan 2025 19:12:27 +0800 Baoquan He <bhe@redhat.com> wrote:
> 
> > On 01/13/25 at 12:01pm, Kirill A. Shutemov wrote:
> > > On Fri, Dec 13, 2024 at 05:49:30PM +0800, Yan Zhao wrote:
> > > > Hi Eric,
> > > > 
> > > > This is a repost of the patch "kexec_core: Accept unaccepted kexec
> > > > destination addresses" [1], rebased to v6.13-rc2.
> > > 
> > > Can we get this patch applied?
> > 
> > This looks good to me. In v1, we have analyzed all other possible
> > solutions, however change in this patch seems the simplest and most
> > accepatable one. 
> > 
> > If Eric has no objection, maybe Andrew can help pick this into his tree.
> 
> OK, but that patch is the only thing in the world which is older than me.
> 
> Yan, can you please refresh, retest and resend?
> 
> Also, please consolidate the changelogging into a single email -
> a single-patch series with a coverletter is just weird.
> 
> Putting the [0/n] info into the singleton patch's changelog is more
> reader-friendly, and that's what counts, no?

Oh, I remember this patch.

Eric, your feedback has been unusably-by-me enigmatic :(

In fact the whole multi-month review discussion has been quite
indecisive.

Yan, please go back through the discussion and incorporate reviewer
feedback into the changelogs: describe the possible issues which people
have raised and your responses to those.  Then resend and then let us
restart the review process.  With less reviewer latency please!

