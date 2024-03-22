Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DCD9EC54E71
	for <kexec@archiver.kernel.org>; Fri, 22 Mar 2024 05:20:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Cc:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=E06aULEtnHA7fYwZqq2Pi2jcMMw46hzOmVMwA/orZ7U=; b=j0eQXfDBLO4Cwt
	wR3YuIqtPAg5Ew+ZOONC6vpfwSUKLhLzdprzCRO160vOD4EbP3qw7/noPL9je7ObwXd515gGsud3v
	AzEUInKvpl+t/DKsf+15VW5fxUbaC37iArtgcIz1uuP8OB2reZ7tSXLVWDawClcLbDaO/ngaqBeXK
	0B35XFJfaArudZsjjk7rPmz7skxzyfb84FSQOeEVIwkHcLaBdwKl7usPa0/Nox+zToH5UzpuCyEDs
	1m7CjD6q1lca++XZ791KvY45Czi8XmFvCljgFTbWK1g5S5RJhqHVSAXn59KSZ4ldx87hAtfAQZVMh
	Kc5QTojUqAHC8uYG51nA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rnXKY-00000005osD-03zB;
	Fri, 22 Mar 2024 05:20:38 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rnXKV-00000005orU-0MBE
	for kexec@lists.infradead.org;
	Fri, 22 Mar 2024 05:20:36 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1711084833;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=QPWt/vpen20Uq0Su+r5r4SqWWuc1vun1fgMIbeuBdwM=;
	b=aLovmRxDhZLT2EsIjp2Bj6rgix+wr4TuaofIIuh1eSPY1rGsu+nxVfB3e3TP4U/iU5WYbJ
	oB9D0Y9Q/atxlcKJcihcNogojna0mf5bN1T83D5ktXz7blolB4ioGoZJyOJ1R33ZC1evuw
	y9iaZzGnTnIzahlw62T0DuzdWD59y88=
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com
 [209.85.166.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-364-A90LMcigOXOQYjriyg37uw-1; Fri, 22 Mar 2024 01:20:30 -0400
X-MC-Unique: A90LMcigOXOQYjriyg37uw-1
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-366b2ee3b5bso6112935ab.1
        for <kexec@lists.infradead.org>; Thu, 21 Mar 2024 22:20:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711084829; x=1711689629;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QPWt/vpen20Uq0Su+r5r4SqWWuc1vun1fgMIbeuBdwM=;
        b=aydxE0sJkPi3swb6SpjheoOdkMX/kKrcvzqGw+5YWut2bC/w6W9JinO2w+gP7ToBfU
         vdH4Sz0wIOrfRU076a/cpSi8lMNr5J3i0yzZVDD8vWJM6e6/vDFmWjZe+z4c2x8pNcnS
         zW8C4QuVoqLXGVRDASF4JDWfAMN11SHLNTf2DSNOCS5Kmc7z/ceAatxMDpoyMZma4aSS
         krlmWT5MoPHqSJsEBmo2C0wqgRIDWZ863FDUv1pswDIE0TZkPWuLNOfWfD12dLvREK2v
         4Czbs8LvksfcV1I+kFjwMkTqmkfjqmWpz148brDlaFtYN7QKLe1ydaxdn5TY6jLjbAs8
         4Aag==
X-Forwarded-Encrypted: i=1; AJvYcCVE1T7a5+mIEQTDenaP4vozLvjNNSQquGDrLr3iENM98CfjgJfNqf2KeWu0Uyv7O5JGQWGl7p8SJHhZeZPXJ94gtf62P6ZHrUzU
X-Gm-Message-State: AOJu0YxIqOohJZnhXkYYGomzrz92Ytcl9Ds0N0DGAphzDDp8s59H+QgZ
	bbZoU2fA6y+zML+8LBqWHFtaucaXO7iMdSag18bL3lO00+snjDbpRO5dH8shS6rjFewyFl9C5fC
	ZSLiuxeZGzCgH9W+lOdbU7OIPcA3NjCKX69s+iZNkggVpIXgH40l15RjMESPtbohido4kLYlkRt
	J5euxc12PakWI2B5efpTipfVasTFBAy5BxJ1uu16nV
X-Received: by 2002:a92:ca06:0:b0:365:2bd4:2f74 with SMTP id j6-20020a92ca06000000b003652bd42f74mr1414327ils.0.1711084829658;
        Thu, 21 Mar 2024 22:20:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHcqpN7yjbXB0akaKxrIaGNwP9eSMrNe1nhA0u4mzAyyJPP5E6Gj96qz1F7MFLE+aoAY3qt4Hni+gmE6ZFGN44=
X-Received: by 2002:a92:ca06:0:b0:365:2bd4:2f74 with SMTP id
 j6-20020a92ca06000000b003652bd42f74mr1414309ils.0.1711084829375; Thu, 21 Mar
 2024 22:20:29 -0700 (PDT)
MIME-Version: 1.0
References: <Zfv8iCL6CT2JqLIC@darkstar.users.ipa.redhat.com>
 <ZfwMribQCTKWSO9l@dwarf.suse.cz> <CALu+AoT2jYfVTFpVvUJv5T+OdSAQzYw0kn74EighK5-4A3O16w@mail.gmail.com>
In-Reply-To: <CALu+AoT2jYfVTFpVvUJv5T+OdSAQzYw0kn74EighK5-4A3O16w@mail.gmail.com>
From: Dave Young <dyoung@redhat.com>
Date: Fri, 22 Mar 2024 13:20:40 +0800
Message-ID: <CALu+AoT4BBFRw7P4gYWBq1PK=Qe2iR=d5YLUY_JyY2CU3SMrYg@mail.gmail.com>
Subject: Re: [PATCH V2] x86/kexec: do not update E820 kexec table for setup_data
To: Jiri Bohac <jbohac@suse.cz>
Cc: x86@kernel.org, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, 
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, 
	"H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org, kexec@lists.infradead.org, 
	Baoquan He <bhe@redhat.com>, Eric Biederman <ebiederm@xmission.com>, 
	"Huang, Kai" <kai.huang@intel.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240321_222035_233609_85EC8697 
X-CRM114-Status: GOOD (  16.77  )
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

> > Your tree is missing this recent commit:
> > 7fd817c906503b6813ea3b41f5fdf4192449a707 ("x86/e820: Don't
> > reserve SETUP_RNG_SEED in e820").
> >
> > Wouldn't this fix [/paper over] your problem as well? I.e., isn't
> > SETUP_RNG_SEED the setup_data item that's causing your problem?
>
> Thanks for catching this, I will rebase and repost.
>
> But it does not "fix" the problem as my problem is related to the
> other setup_data
> range, I think it is SETUP_PCI (not 100% sure, but it is certainly not RNG_SEED)
>

The webmail reply broke the lines randomly, sorry for that.  I have
resent a rebased version.  And I also confirmed that in my case it was
SETUP_PCI caused the issue.   Note, this SETUP_PCI is from previous
physical bootup, the old kernel reserved it in kexec e820, it is not
the RNG_SEED which was passed in by kexec.  I believe the RND_SEED
region could cause issues only on the 3rd+ boot with a kernel without
the commit you mentioned.

It is a little tricky, I suppose not obvious to understand..

Thanks
Dave


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
