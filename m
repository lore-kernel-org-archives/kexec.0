Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0254BC44515
	for <kexec@archiver.kernel.org>; Fri, 17 Jul 2026 19:41:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Cc8aVZtebMWgQf9o/5yCOKG8fzMb7f5xhxINPxPhrtE=; b=rhfjmx9SgIy34uQLqceh7Hhrgs
	aQ46CplmCBEyvZihZH26vgqRjmv9pdk0wzGJxLlLX0HuduptbLhcuVRR0esSKg8CtMemZFojjLRBY
	SQLWMIGpiM9ePj9xvO5zqRK3buTEU+9+2NwtNk1AS6Z1tsUGnRpID8DWIABX9Zv74KC8kWUqZPBxj
	3LpgFmYzHc0UxXG3XuDHP/Cd61dwPN3lcOdQLlIOLlzyorCIL8wLKfS4GVJHTg9dSQ3ropO5RBzFj
	7xZAv35K9kWAcGIgK+DU8Roic1Y9+FO26d3lpMfUwH4sSqXZGrFEjJ1MUFscmKbymYiHz33VBM3Cr
	wyEQuhxQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wkoQh-000000039IZ-3Iky;
	Fri, 17 Jul 2026 19:41:03 +0000
Received: from mail-qk1-x731.google.com ([2607:f8b0:4864:20::731])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wkoQf-000000039I8-3Fnl
	for kexec@lists.infradead.org;
	Fri, 17 Jul 2026 19:41:02 +0000
Received: by mail-qk1-x731.google.com with SMTP id af79cd13be357-92ed3993c1eso310822085a.1
        for <kexec@lists.infradead.org>; Fri, 17 Jul 2026 12:41:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1784317261; x=1784922061; darn=lists.infradead.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Cc8aVZtebMWgQf9o/5yCOKG8fzMb7f5xhxINPxPhrtE=;
        b=hcgEmzttQnYnA0WP8OeGdH3ybkMpeFzahljY4HMt2JV87SU6Yu95jVh8lBrCO4sP7X
         r2E+F6voxHEERnJeKHDPcr+UCPkq6F5DzmPP8WEEpRJ0bx4AqEjOmtjrowYaq1yTdyXB
         gf0NuvmpTDxWvJtJteN1GOUcwS2n1/Ni66gKbDZMHG6EJxWaK2cSD6Wzj1u1lzKBxnvk
         hWrlJAnlsoltgnT9UsWZpD29AKk9QhHZe7zgVBdIBw69ISLF1Ad2HqzI+bkksFY7Pu4i
         E6G58zOXSCZLrhrw9w42Hm/csfYUUevVq2Ic4CgbjMeJuOoJxVuD0qqp6fJh76mwo9rh
         F/9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784317261; x=1784922061;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Cc8aVZtebMWgQf9o/5yCOKG8fzMb7f5xhxINPxPhrtE=;
        b=MPZ9+ZUHJlTV9hnnLJgqfiSvVPbhKGhoR9jLRrJNQxpHuRU/5jVXizSVanATaMS6R+
         T8iJXD1nuB8ryCTzNGHm4aFFiaXtCpt7EsRF8emti6GH+YLkNsxka/qUEFfO7qRKpgmb
         PqfWwvD2h9wRf445GdN903G6xeVj+V+H0XCRl91IKSgODYaCfeMeCdd803mzzu3DA/VM
         5t4Noa+D4FQ6/jYo8qKzjlfjRtYvCg6qDZD+oBznFBzZfeoFIzhsC3lPkyPg5+6s53A2
         X6gwB0z42UCPgyvw9xKoP+npTI1Q5X7GbuUHkf3dGnrsWVQBkAvSRySQkGdZlY2owhvf
         u35w==
X-Forwarded-Encrypted: i=1; AHgh+RqgEQklp9Rn8bQ/S8PYLYC/ESgQhl+M4fET0++ledwV/SSXDsmMiKKbXjXEpG4wR7jZNVO1gQ==@lists.infradead.org
X-Gm-Message-State: AOJu0YysXyFS3tnLehgpoMeDe6g9nTPCUDm/aRPsBI/WbEyAunHv+811
	XZyF7pspjZkkj+1QJEcsElAOO7Vo7SBbXQydyu8rsn0npYttZzJnzcmQ8HZfZO3kGTw=
X-Gm-Gg: AfdE7ck5x7vsvrRgvWLdn7QQ7b+SafYydcXOpAhsR8jeW8qBspACuPPBcp34IYeIBSq
	453KreWi2w03ZqDJhH4qqI17PV6Z9WFtc9OT0Pfo/D/dAcPA2zNgf6VV+pfNgjNaiY95SwBD9HI
	QyrLjvLw/BhjkKcD+YuytKrERwS9A+LKZah8tVxkjsX+cbDfi9BL6G8EGiOzgcfwpIxdznKfmRJ
	RHlP1UlbLD1wORdA0WdpdxrINCDUN5RLdTY0ZIj7IKR1rW9Mm55u6zHFoKCTLbk/6VOhW5/W69L
	96YtcpVZoDq53ls+8ebGg0NO+CEhjd21zmHuFjHpgbFpV53uuw8mRsEmcyfAuxU+BALmcEjfsrT
	kmZlrOF1Xk0MyHoQ690cs13Uetf5LbekN/Ta04ob1nxDChGa8Qb1bln6/FB+iKewfR5SE9xbsNf
	gM+mHOiBm+sI0mkJpfAlgTb6QgO0iIkg==
X-Received: by 2002:a05:620a:a197:20b0:92e:c116:bef7 with SMTP id af79cd13be357-930b4315f1cmr311099685a.84.1784317260004;
        Fri, 17 Jul 2026 12:41:00 -0700 (PDT)
Received: from plex ([71.181.43.54])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-930b52dff03sm230279385a.9.2026.07.17.12.40.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jul 2026 12:40:59 -0700 (PDT)
Date: Fri, 17 Jul 2026 19:40:58 +0000
From: Pasha Tatashin <pasha.tatashin@soleen.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Pasha Tatashin <pasha.tatashin@soleen.com>, 
	David Matlack <dmatlack@google.com>, kexec@lists.infradead.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, linux-pci@vger.kernel.org, 
	Adithya Jayachandran <ajayachandra@nvidia.com>, Alexander Graf <graf@amazon.com>, 
	Alex Williamson <alex@shazbot.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	Chris Li <chrisl@kernel.org>, David Rientjes <rientjes@google.com>, 
	Jacob Pan <jacob.pan@linux.microsoft.com>, Jonathan Corbet <corbet@lwn.net>, 
	Josh Hilke <jrhilke@google.com>, Leon Romanovsky <leonro@nvidia.com>, 
	Lukas Wunner <lukas@wunner.de>, Mike Rapoport <rppt@kernel.org>, Parav Pandit <parav@nvidia.com>, 
	Pranjal Shrivastava <praan@google.com>, Pratyush Yadav <pratyush@kernel.org>, 
	Saeed Mahameed <saeedm@nvidia.com>, Samiullah Khawaja <skhawaja@google.com>, 
	Shuah Khan <skhan@linuxfoundation.org>, Vipin Sharma <vipinsh@google.com>, William Tu <witu@nvidia.com>, 
	Yi Liu <yi.l.liu@intel.com>
Subject: Re: [PATCH v7 01/12] PCI: liveupdate: Set up FLB handler for the PCI
 core
Message-ID: <alqE_-OR-rB15Crx@plex>
References: <20260710212616.1351130-1-dmatlack@google.com>
 <20260710212616.1351130-2-dmatlack@google.com>
 <178431652443.189683.17611165218179620081.b4-review@b4>
 <20260717193055.GD699082@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260717193055.GD699082@nvidia.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260717_124101_824112_3A42F6A0 
X-CRM114-Status: GOOD (  14.85  )
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

On 07-17 16:30, Jason Gunthorpe wrote:
> On Fri, Jul 17, 2026 at 07:28:44PM +0000, Pasha Tatashin wrote:
> > On Fri, 10 Jul 2026 21:26:04 +0000, David Matlack <dmatlack@google.com> wrote:
> > > diff --git a/drivers/pci/liveupdate.c b/drivers/pci/liveupdate.c
> > > new file mode 100644
> > > index 000000000000..899758883dd5
> > > --- /dev/null
> > > +++ b/drivers/pci/liveupdate.c
> > > @@ -0,0 +1,155 @@
> > > [ ... skip 50 lines ... ]
> > > +#include <linux/slab.h>
> > > +
> > > +/**
> > > + * struct pci_flb_outgoing - Outgoing PCI FLB object
> > > + * @ser: Pointer to the preserved struct pci_ser.
> > > + * @block_set: The KHO block set holding the outgoing devices.
> > 
> > AFAIK, these should be aligned after column:
> > @ser:       Pointer to ...
> > @block_set: The KHO block ...
> 
> Gosh I hope not, I never do that. The horizontal alignment is such a
> PITA to maintain.

Agreed. I just see that everywhere, so I thought it was the rule. If 
not, that is great; I hate them myself.

> 
> Jason

