Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C56A1CAC59A
	for <kexec@archiver.kernel.org>; Fri, 19 Sep 2025 06:59:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=xtcgVCi+G898H3JycH7loc6tUgEzYyu4N3/qLFW16pM=; b=bkW1nKe/nThlj673RX6jQ9xbon
	Pprq1SvjTuw0Zd1AtlNlcrp63gnPNF/nC2iamzqUTWDqTd9cle9Ls+6A7AD8OwYrGwlU6MnQ9nXOu
	hIrdLrM+DVGjcs0hmzdwXjqTUm0d+63XAXuel8IwaVDQ2P58NqlyA+d6F7iea/JKT57lD63YOxodq
	lHCFzQ2Gdg2hl4HLdhygtCqzMS13w8kpu4kvf95SnnVxtna9DxVzFFkaAA7Tn5Y/zLJbL75+MMTM9
	x3vYCu833088//vqxES+LKdMpWwuYbT0PV+DnYmzc51N+haMIRWf15hfXus4/oKbBsIx567n3JJT4
	8Z5m82qw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uzV5D-00000001zFD-0GRU;
	Fri, 19 Sep 2025 06:59:03 +0000
Received: from mail-vs1-xe34.google.com ([2607:f8b0:4864:20::e34])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uzV5A-00000001zEr-2iSO
	for kexec@lists.infradead.org;
	Fri, 19 Sep 2025 06:59:01 +0000
Received: by mail-vs1-xe34.google.com with SMTP id ada2fe7eead31-52dd67b03c8so1221082137.2
        for <kexec@lists.infradead.org>; Thu, 18 Sep 2025 23:59:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758265139; x=1758869939; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xtcgVCi+G898H3JycH7loc6tUgEzYyu4N3/qLFW16pM=;
        b=HMq5l3EH/uTgSkU4Eu+MujLIJsTW9uheWABhVYrV9vV5Z1IxU92RWHMcxDWF0A5k2U
         6CvyOYPcjYJ5Tx8Judn5Q1xk9vACKytMRqpKV6ekWnrEtsp+SrzzZe5UDPQJhvLu0586
         Vg3i/NpNAybcyeQ2dRhAMux5+Lr3UlT4/b2KVTTJWDartWIPHw9vVX1H8TNfFIBzHY50
         pJKeJmZFx7Whz2yocxWUGhea+N5k9WXbntEbIR4KPJCOizALERrCulTUqTyet97wqsJx
         9HG9h5+YMtamwa2rUo24O5+s5XENcO8oKT8tvqX+BACIsvwdQB4CIub++C34d1VX7Uj6
         974A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758265139; x=1758869939;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xtcgVCi+G898H3JycH7loc6tUgEzYyu4N3/qLFW16pM=;
        b=NVB/YVqPN9SVOXKYO/6kt7+9tEEJA7qc40gSYEYDmWFYKkj6JQb5dyxOSGxlOoGnkN
         Xto4HMG6ug9FXNT9HcyK1x6JMtU10BQHl8a/XB33l/unWb4DM3idHJJH/v0U5dh7tNYR
         DxHL8hN5sYaS3nckrH3DH4BuqUB/o1nWXx2gOdQ74P7/g+nmeAD584Qx2EeSMQmXhJ7l
         /pyFvsFVpOA3opF2lNxSXDwcjFZOQ48LRUxljlZn+dvphkyPXHWKsMv7XAteUe9YPjs3
         OmA5w3X+OLc1uqE9me2fBAsFiXR+x8C5inYM0daUDS7A8eSc5epb0MBw1Y/hv2B2mMi+
         izDQ==
X-Forwarded-Encrypted: i=1; AJvYcCWZaPtCSexRBoopFxxHf54pRUoIejR+wQETlCT1qWXqGOMeqtOaEkybou1Ohliu3zEW8h2IGg==@lists.infradead.org
X-Gm-Message-State: AOJu0Yx8ZEFGtgHELvtG7eYy1fw/ljBtZ7knKIkbGLMIzDZB1TKtMus3
	A3kdgTyjb7mHqutl6mBd9dIZyc3UoBN7GMoasFp1422F4xmrgo8Mv/y1NAHZqExEPrOrz2pWK1d
	22aHgltO3jSpn/goIyFAHQvTxtpq3sRm3g7oz36Im
X-Gm-Gg: ASbGncsMOTtN816DnJHVEPp1cd61sHmVkHdLzKrutyUNXY8G9QXWTh71WydwSxVE2Ej
	KU9tbg71KvcqS6ENLG0R4enSzkL5SBhTDc4LSynR+rcm1fjsig5jY3w7Pk5IPBuGWPAFp50ljYH
	ZgY5VI+8o2ez+FveKIuByyddoSdEA7Dj1aFP/TTwpxBas99p+YvauMoTPpHu8F9Qs+YvLh6XC3i
	BigFyicHVe4s5ro+i5r5laawX4MxrHr1NrKNw==
X-Google-Smtp-Source: AGHT+IHk3HVC3jvHLLDRmh37Xu/EchCNrhbpXqT1eVIU2RepMDaci0Ybt3B7Crf5TYbbvxxQhcjhhhXUFlwv46zm7xc=
X-Received: by 2002:a05:6102:3347:b0:529:4cf5:8aec with SMTP id
 ada2fe7eead31-588ec1dd609mr784951137.16.1758265139130; Thu, 18 Sep 2025
 23:58:59 -0700 (PDT)
MIME-Version: 1.0
References: <20250917025019.1585041-1-jasonmiu@google.com> <20250917025019.1585041-3-jasonmiu@google.com>
 <aMr1XAKmyfzM8RCc@kernel.org>
In-Reply-To: <aMr1XAKmyfzM8RCc@kernel.org>
From: Jason Miu <jasonmiu@google.com>
Date: Thu, 18 Sep 2025 23:58:47 -0700
X-Gm-Features: AS18NWA-W3pRg8J4Q0PVvMgsoADaqk7Awe1gJKAjZHyCKtolHE0_0MrSoYHTlwM
Message-ID: <CAHN2nPL6SV_Y6Sxqy4o-mOPZoGYMoWow=KevUTX6=c8JkO_g8g@mail.gmail.com>
Subject: Re: [RFC v1 2/4] kho: Adopt KHO page tables and remove serialization
To: Mike Rapoport <rppt@kernel.org>
Cc: Alexander Graf <graf@amazon.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Baoquan He <bhe@redhat.com>, Changyuan Lyu <changyuanl@google.com>, 
	David Matlack <dmatlack@google.com>, David Rientjes <rientjes@google.com>, 
	Jason Gunthorpe <jgg@nvidia.com>, Joel Granados <joel.granados@kernel.org>, 
	Marcos Paulo de Souza <mpdesouza@suse.com>, Mario Limonciello <mario.limonciello@amd.com>, 
	Pasha Tatashin <pasha.tatashin@soleen.com>, Petr Mladek <pmladek@suse.com>, 
	"Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, Steven Chen <chenste@linux.microsoft.com>, 
	Yan Zhao <yan.y.zhao@intel.com>, kexec@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250918_235900_695214_D4A15BDA 
X-CRM114-Status: GOOD (  20.71  )
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

Hi Mike,

Thank you very much for your comments!

On Wed, Sep 17, 2025 at 10:52=E2=80=AFAM Mike Rapoport <rppt@kernel.org> wr=
ote:
> > -/*
> > - * TODO: __maybe_unused is added to the functions:
> > - * kho_preserve_page_table()
> > - * kho_walk_tables()
> > - * kho_memblock_reserve()
> > - * since they are not actually being called in this change.
> > - * __maybe_unused will be removed in the next patch.
> > - */
> > -static __maybe_unused int kho_preserve_page_table(unsigned long pfn, i=
nt order)
> > +static int kho_preserve_page_table(unsigned long pfn, int order)
>
> Just merge this and the previous patch so that the patch will replace the
> current preservation mechanism with a new one.

Sure I can do this.

> > @@ -1023,12 +752,8 @@ int kho_preserve_folio(struct folio *folio)
> >  {
> >       const unsigned long pfn =3D folio_pfn(folio);
> >       const unsigned int order =3D folio_order(folio);
> > -     struct kho_mem_track *track =3D &kho_out.ser.track;
> > -
> > -     if (kho_out.finalized)
> > -             return -EBUSY;
> >
> > -     return __kho_preserve_order(track, pfn, order);
> > +     return kho_preserve_page_table(pfn, order);
>
> I don't think we should "rename" __kho_preserve_order() to
> kho_preserve_page_table(). __kho_preserve_order() could use the new data
> structure, or call the new implementation, but I don't see a reason to
> replace it.
>

Ok, I prefer calling the new implementation, so it will look like:

kho_preserve_folio() -> __kho_preserve_order() -> __kho_preserve_page_table=
()

 __kho_preserve_page_table() is the internal implementation of
kho_preserve_page_table() and we can remove the
kho_preserve_page_table().

--
Jason Miu

