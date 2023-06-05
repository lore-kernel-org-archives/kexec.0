Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21074C7EE2C
	for <kexec@archiver.kernel.org>; Mon,  5 Jun 2023 02:36:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=EVCNhP1ZrD617G92KzJNiHF5DMa5XwxF55NXnYHX0Oo=; b=whoCuQCnvFzEFaCttJD3PTSUoy
	bBaFzcUkXFOzGpe4GD7DyOX1//HPLBPF01OTBlOuH6NLfQSMJCQkw7t5+1Z9ZzpusF4QltrKohca2
	Ne3g0uKSARV0sDVrpmnjBrNdkt3OBWLrlNerF+3ZGwozbrAvm3rQ4Hm6UtkAnyjGfqYCsmK88ZGdG
	jb83dRLhrPfBUGn97gI1Hpp54u+H4XYsv31BD8LrQ0shvbITyHOkEjF4pFRzzepWN5godNVrD/m6M
	Ozuj1e/6Nt4+4DwAFzgbVrANDCBEWapmXWMclrO3vUKB9fZZjKu+5Dsns4lw/2XAUMVHz/R+XU7lq
	MDWOe21A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1q604b-00Dmtd-09;
	Mon, 05 Jun 2023 02:35:57 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1q604X-00DmsO-2l
	for kexec@lists.infradead.org;
	Mon, 05 Jun 2023 02:35:55 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1685932551;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=wbOf9YixGxYUT6+A1F/Xkspb+6fjMJ6LMndsBADdRu0=;
	b=Y2FS6KRRpExxDdCJZ2+pwofxT1ohTwe4t4Sz+BovDJYyZWy1AusALZRPf9HhOZSYQ/tW7q
	CFT9Y68RlffY/1peJBywS+ZhSAXOyIpOrOxZKolTUcjaal4xACqGIQ7GQATehh7JAZZJn9
	j3fwWkQ5gG+bvfoHghHe7+ltMckeLWU=
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-231-j-eMqNlPO4uXDHuHoOCseA-1; Sun, 04 Jun 2023 22:35:48 -0400
X-MC-Unique: j-eMqNlPO4uXDHuHoOCseA-1
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-1b0336355a4so39765615ad.1
        for <kexec@lists.infradead.org>; Sun, 04 Jun 2023 19:35:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685932547; x=1688524547;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wbOf9YixGxYUT6+A1F/Xkspb+6fjMJ6LMndsBADdRu0=;
        b=RYzIoqXDMW0fiddXnQ8st5xghTl9bt34L8oehn0hxE0wSkjsrBLC4J/Wpm/p0oUaAB
         xx+hc3+BFO6NyAJ10sqaPmFxee9BTyh1eRb8yzz0Uh9TfBvuqtl9+nbZmzfaZgHSC0jb
         EXkGiND732OpoBy1673dd4h6JNwrbzugB0mTVfvLsfvGrcvoY2ghPcx/hoc4uiIYOwUn
         R7jQKhroVXbVDrW6rwGXn+dMTCL4qG9eBeA9LRro4YVc0aIeDVgbw2Qj0B8SNiAYjC0l
         54xWgFfo5VbY9lfL6Yg4LdqRSH9jTNAdNfXtjabYXOWqjV5TApM+IK6K/CEY755RuW1+
         dw8Q==
X-Gm-Message-State: AC+VfDxhRs9tM5jwaQTzhKPXVc4D7DMGLHcCcTkhcS/+Rn40d3P0KX+N
	HThKeDzWB3BrcbXDoSQwa78uwj1qQmyJAw0G5Lhrq7tfxYLNmpDobG+iJmWe9FbuTXVCa7FEM/b
	FByzIimpgrs7ZvSaJCLhE
X-Received: by 2002:a17:902:c20d:b0:1a9:b0a3:f03a with SMTP id 13-20020a170902c20d00b001a9b0a3f03amr5828586pll.9.1685932546967;
        Sun, 04 Jun 2023 19:35:46 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7RPcaCQNdS4CeYjKEEsiTHolnzKdcAYpiF586LtFjStL6H4T9gcjFxgb0r6IqczKNCCCAZmw==
X-Received: by 2002:a17:902:c20d:b0:1a9:b0a3:f03a with SMTP id 13-20020a170902c20d00b001a9b0a3f03amr5828575pll.9.1685932546645;
        Sun, 04 Jun 2023 19:35:46 -0700 (PDT)
Received: from localhost ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id h9-20020a170902748900b001b05e97ee09sm5218208pll.283.2023.06.04.19.35.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Jun 2023 19:35:46 -0700 (PDT)
Date: Mon, 5 Jun 2023 10:31:49 +0800
From: Coiby Xu <coxu@redhat.com>
To: Eric Biggers <ebiggers@kernel.org>, Milan Broz <gmazyland@gmail.com>
Cc: kexec@lists.infradead.org, Baoquan He <bhe@redhat.com>, x86@kernel.org, 
	dm-devel@redhat.com, Pingfan Liu <kernelfans@gmail.com>, linux-kernel@vger.kernel.org, 
	Dave Hansen <dave.hansen@intel.com>, Kairui Song <ryncsn@gmail.com>, 
	Jan Pazdziora <jpazdziora@redhat.com>, Thomas Staudt <tstaudt@de.ibm.com>, 
	Vitaly Kuznetsov <vkuznets@redhat.com>, Dave Young <dyoung@redhat.com>
Subject: Re: [PATCH 0/5] Support kdump with LUKS encryption by reusing LUKS
 volume key
Message-ID: <36mz3gn764ceadfbuhhmoo2zaiqmzplpkdcnszha2hzhmb3i62@sm6hilxryzk4>
References: <20230601072444.2033855-1-coxu@redhat.com>
 <20230602213452.GC628@quark.localdomain>
 <f569a35a-bff9-9dbb-2ded-7e02ee060a9a@gmail.com>
MIME-Version: 1.0
In-Reply-To: <f569a35a-bff9-9dbb-2ded-7e02ee060a9a@gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230604_193553_993485_D3F3C854 
X-CRM114-Status: GOOD (  20.05  )
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

Hi Eric and Milan,

On Sat, Jun 03, 2023 at 11:22:52AM +0200, Milan Broz wrote:
>On 6/2/23 23:34, Eric Biggers wrote:
>>On Thu, Jun 01, 2023 at 03:24:39PM +0800, Coiby Xu wrote:
>>>[PATCH 0/5] Support kdump with LUKS encryption by reusing LUKS volume key
>>
>>The kernel has no concept of LUKS at all.  It provides dm-crypt, which LUKS
>>happens to use.  But LUKS is a userspace concept.
>>
>>This is a kernel patchset, so why does it make sense for it to be talking about
>>LUKS at all?  Perhaps you mean dm-crypt?
>
>Exactly.

Thanks for raising the above concern! The use cases like CoreOS and
Confidential VMs explicitly want kdump to work for LUKS. And correct me
if I'm wrong, I think the two problems addressed by this patch set only
apply to LUKS so the kdump part of the kernel only cares about the LUKS
case. If there are use cases where similar approach is needed, I'll be
happy to make the solution more generic.

>
>I had the same comment almost a year ago... and it still applies:
>https://lore.kernel.org/all/c857dcf8-024e-ab8a-fd26-295ce2e0ae41@gmail.com/
>
> Anyway, please fix the naming before this patchset can be read or reviewed!
>
> LUKS is user-space key management only (on-disk metadata); the kernel has
> no idea how the key is derived or what LUKS is - dm-crypt only knows the key
> (either through keyring or directly in the mapping table).
>
> Polluting kernel namespace with "luks" names variables is wrong - dm-crypt
> is used in many other mappings (plain, bitlocker, veracrypt, ...)
> Just use the dm-crypt key, do not reference LUKS at all.

Thanks for the reminding! That comment was on the first RFC version. But
starting with "RFC v2", there is no longer any interaction with dm-crypt
(to save a copy of the LUKS volume key for the kdump kernel) and now I
make cryptsetup talks to the kdump part of the kernel via the sysfs to
reuse the volume key. So only the kdump part of the kernel needs to know
LUKS which is what it cares. Thus I don't think there is any kernel
namespace pollution now.

>
>Milan
>

-- 
Best regards,
Coiby


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
