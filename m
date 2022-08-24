Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84DFCC00140
	for <kexec@archiver.kernel.org>; Wed, 24 Aug 2022 16:52:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Date:Cc:To:From:Subject:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=ru2Gq654n4oobQMTnRdjgtK+YrV9OBpsp6RKJYqLAzY=; b=voey4u0RfOkYf3
	aF5dOQqxuOOEaCrx6CIeqto/Wd3RxPgoOmq3FicQJo0T66v75dmytGuklP7xrEQRBdsTzCxJPjHEW
	RplS8rqC31kdUkr+EQS8S663aHSkIVaLo1hBTm7BFjdCCYaFDOH6ZXzKTlDQzl5uReQycUT1nshUi
	DGsDRcSmDI9BeR4V9ayClDMpRzCiyrMAXnt8x2zl+AkPA6eCXCKtVkDx8N/gBXeiPB5dxICm6NzdJ
	IRzZsOla6ojmXG38PW0W1LbwyI/Q35FvVA++bjP+Vycr7xtnFyXm+s56fd1AHRzh2jsBn6qNsRieW
	xx71rtzc6iBPVJR0yEjQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oQtc6-00EYb2-D1; Wed, 24 Aug 2022 16:52:22 +0000
Received: from smtprelay0013.hostedemail.com ([216.40.44.13] helo=relay.hostedemail.com)
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oQtc3-00EYXs-0h
	for kexec@lists.infradead.org; Wed, 24 Aug 2022 16:52:20 +0000
Received: from omf07.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay10.hostedemail.com (Postfix) with ESMTP id C3D66C024E;
	Wed, 24 Aug 2022 16:52:09 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf07.hostedemail.com (Postfix) with ESMTPA id 696E12002C;
	Wed, 24 Aug 2022 16:52:06 +0000 (UTC)
Message-ID: <3c250aa26020b2f336fd575a58d06ba26faf1f14.camel@perches.com>
Subject: Re: [PATCH RFC 2/2] checkpatch: warn on usage of VM_BUG_ON() and
 friends
From: Joe Perches <joe@perches.com>
To: David Hildenbrand <david@redhat.com>, linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org, linux-doc@vger.kernel.org,
 kexec@lists.infradead.org,  Linus Torvalds <torvalds@linux-foundation.org>,
 Andrew Morton <akpm@linux-foundation.org>, Ingo Molnar <mingo@kernel.org>,
 David Laight <David.Laight@ACULAB.COM>, Jonathan Corbet <corbet@lwn.net>,
 Andy Whitcroft <apw@canonical.com>, Dwaipayan Ray
 <dwaipayanray1@gmail.com>, Lukas Bulwahn <lukas.bulwahn@gmail.com>, Baoquan
 He <bhe@redhat.com>, Vivek Goyal <vgoyal@redhat.com>, Dave Young
 <dyoung@redhat.com>
Date: Wed, 24 Aug 2022 12:52:05 -0400
In-Reply-To: <20220824163100.224449-3-david@redhat.com>
References: <20220824163100.224449-1-david@redhat.com>
	 <20220824163100.224449-3-david@redhat.com>
User-Agent: Evolution 3.44.4 (3.44.4-1.fc36) 
MIME-Version: 1.0
X-Stat-Signature: jucjcx4acoerrt8q895fp6htgrjxts67
X-Rspamd-Server: rspamout04
X-Rspamd-Queue-Id: 696E12002C
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX1/ObFLiNI+vpAgQqKNzyIkOlEeiH6U5Lr8=
X-HE-Tag: 1661359926-188978
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220824_095219_140945_7CBB41B9 
X-CRM114-Status: GOOD (  16.97  )
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

On Wed, 2022-08-24 at 18:31 +0200, David Hildenbrand wrote:
> checkpatch does not point out that VM_BUG_ON() and friends should be
> avoided, however, Linus notes:
> 
>     VM_BUG_ON() has the exact same semantics as BUG_ON. It is literally
>     no different, the only difference is "we can make the code smaller
>     because these are less important". [1]
> 
> So let's warn on VM_BUG_ON() and friends as well. While at it, make it
> clearer that the kernel really shouldn't be crashed.
> 
> Note that there are some other *_BUG_ON flavors, but they are not all
> bad: for example, KVM_BUG_ON() only triggers a WARN_ON_ONCE and then
> flags KVM as being buggy, so we'll not care about them for now here.
[]
> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
[]
> @@ -4695,12 +4695,12 @@ sub process {
>  			}
>  		}
>  
> -# avoid BUG() or BUG_ON()
> -		if ($line =~ /\b(?:BUG|BUG_ON)\b/) {
> +# do not use BUG(), BUG_ON(), VM_BUG_ON() and friends.
> +		if ($line =~ /\b(?:BUG|BUG_ON|VM_BUG_ON|VM_BUG_ON_[A-Z]+)\b/) {

Perhaps better as something like the below to pick up more variants

		if ($line =~ /\b(?!KVM_|BUILD_)(?:[A-Z_]*_)?BUG(?:_ON)?(?:_[A-Z_]+)?\s*\(/

>  			my $msg_level = \&WARN;
>  			$msg_level = \&CHK if ($file);
>  			&{$msg_level}("AVOID_BUG",
> -				      "Avoid crashing the kernel - try using WARN_ON & recovery code rather than BUG() or BUG_ON()\n" . $herecurr);

and maybe:

				      "Do not crash the kernel unless it is unavoidable - use WARN_ON_ONCE & recovery code (if reasonable) rather than BUG() or variants\n" . $herecurr);


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
