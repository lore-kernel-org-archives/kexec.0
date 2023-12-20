Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77069C3DA6E
	for <kexec@archiver.kernel.org>; Wed, 20 Dec 2023 15:46:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Mime-Version:References:In-Reply-To:
	Message-Id:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=mczVmjFToGSOtOMtQhsEg+2J+0OsJRFEP4oiPNI8I+w=; b=FwNIMuA6p58IiF
	HB9mdIjsDrh91hRIfVsjVbySo8Ll9Ju9oqjlES4Bq2/i6Cms1RXPzOhTKrByVDxIbq2pHvhDd+6DR
	FM5fnIYg15jUlcaJofincMuxWHPhEbDLDzJKnlLICYesiacRAK6+pkVF6Iym/dqR3fGPdqynGi2G6
	wpHeTr7/dV64jkCAzrGUgcJZNGyORJVHYlCnfrlWiazGzP0hIAQxNWYdANRBKGpcIgtq3k7ww3+l+
	pTWEUsTqj8piBuQDqqcG5ZeDY3karNAETUqDrxCNNrMYoLrk+qO+wxKVOn6mfvFqsWYOZs66iXGVw
	ngJJGvYdFnT5PkGaVWiQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rFymP-000IDS-2V;
	Wed, 20 Dec 2023 15:46:41 +0000
Received: from sin.source.kernel.org ([145.40.73.55])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rFymN-000ICb-0Y;
	Wed, 20 Dec 2023 15:46:40 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id E172FCE174E;
	Wed, 20 Dec 2023 15:46:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC20AC433C7;
	Wed, 20 Dec 2023 15:46:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1703087196;
	bh=msAgnUJbaRwfm0a89d9Fghf3puPMYUbmDNZfg/0kRDo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=AVC49m9FN7UGqMos9JDgfGONK9pW0mV8N1W5Vv3mUk6F8twDEkxVRjNuBW5IX5JUG
	 0nLJsru7WPnunGTjb8v+22r3+58p8Imo1VC0eV03PaX/vc6dYu8/ZTuhs9iN6RDN2k
	 DT9h9/+GrpK5JBrs2or6PwZlDKEuYDvIQ3LPCpIY=
Date: Wed, 20 Dec 2023 07:46:34 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: Baoquan He <bhe@redhat.com>
Cc: Conor Dooley <conor@kernel.org>, linux-kernel@vger.kernel.org,
 kexec@lists.infradead.org, x86@kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-riscv@lists.infradead.org,
 linuxppc-dev@lists.ozlabs.org, linux-parisc@vger.kernel.org,
 joe@perches.com, nathan@kernel.org
Subject: Re: [PATCH v4 5/7] kexec_file, ricv: print out debugging message if
 required
Message-Id: <20231220074634.cd736ec567cd7adf1e4c6d7e@linux-foundation.org>
In-Reply-To: <ZYJsBW0Y7Y+XhSgf@MiWiFi-R3L-srv>
References: <20231213055747.61826-1-bhe@redhat.com>
	<20231213055747.61826-6-bhe@redhat.com>
	<20231219-twitch-many-ca8877857182@spud>
	<ZYJsBW0Y7Y+XhSgf@MiWiFi-R3L-srv>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231220_074639_472235_23648805 
X-CRM114-Status: UNSURE (   7.34  )
X-CRM114-Notice: Please train this message.
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

On Wed, 20 Dec 2023 12:22:29 +0800 Baoquan He <bhe@redhat.com> wrote:

> Could you help fix the typo in subject?
> 
> [PATCH v4 5/7] kexec_file, ricv: print out debugging message if required
>                            ~~~ s/ricv/riscv/

I made that change.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
