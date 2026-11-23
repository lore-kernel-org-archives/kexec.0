Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF1F3606A31A
	for <kexec@archiver.kernel.org>; Mon, 23 Nov 2026 19:07:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=lXJEPMR0;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=HV1+aAED
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:References:Cc:To
	:From:Subject:Message-Id:Date:Content-Type:Content-Transfer-Encoding:
	Mime-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=+QayBEQiT3Jk/QfXswrgR8TXyR2eeqhw4QSoy3wq6uU=; b=lXJEPMR08Uc/6b
	w9yJgt95nqwTrUaEiuuapmEs361VmIHDeOeFHc349uNgr8QglXSoSxw9znPTQPlJd6RPWkDGwwz6t
	3vHTxEixLdBdm/02Y0xvW3dpyPZ0l/nMYVM/ucqas36pQM4OfH7QQSOQLPQ6CUmYFcLIkNrc0jeBm
	tCrU+rKpmgNQbe4gVZHoiPM1kQYQ/CXNY4yGWb3VY4un+SSCS7jMVYbbm01X7tzYYfGNbcfw8WHk3
	xz6rPsI9t3oLia9bZxG7WzTTalZlamFrnDYGNiHPi5Ui/1nvaGGchnMd4YSVLY8VE5T4tODWN3fTL
	rWwzzYKW2FZkBnF3QzJA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xVZNe-00000004cJn-1GxD;
	Mon, 23 Nov 2026 19:07:10 +0000
Received: from mail-pj1-x102a.google.com ([2607:f8b0:4864:20::102a])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xVZNb-00000004cIs-1OUf
	for kexec@lists.infradead.org;
	Mon, 23 Nov 2026 19:07:08 +0000
Received: by mail-pj1-x102a.google.com with SMTP id 98e67ed59e1d1-3b4cd193b50so30197a91.1
        for <kexec@lists.infradead.org>; Mon, 23 Nov 2026 11:07:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795460826; x=1796065626; darn=lists.infradead.org;
        h=in-reply-to:references:cc:to:from:subject:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=+QayBEQiT3Jk/QfXswrgR8TXyR2eeqhw4QSoy3wq6uU=;
        b=HV1+aAEDr8gQNgiTa2jR1qUEhVjf34gc0nwp6Y1ltEvJXh7OEYO7OAXjVjG7rGJLu2
         lje1SdYwSjIRwGH7CeFkRkOzX/acOYvXQ61KatsYif3hjxDLBNkoGpn0nz/g97uuAMXG
         r0PbsFpRA9h+62scKMHaUqo3QMIZW5im4NWm+B7u1umfOm9IZUY6ZbJwxNU6mmfGySKX
         onCAKDitc+mibxZEicTSsI6STbocT2Aw+YErWSle6bsel3xLW8HrYYCmLAB0qmWB5Da/
         AZXslPd1ehC2eXGqpGaLAvEDaC5gchSri9YcmcEJvE9nXO1HQW3nhOcQ6rj2qmfLeH1W
         qGWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795460826; x=1796065626;
        h=in-reply-to:references:cc:to:from:subject:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+QayBEQiT3Jk/QfXswrgR8TXyR2eeqhw4QSoy3wq6uU=;
        b=s9BtStCkZFFOTCI6G8StrEqZbqLhwh8Tfpn9ZDAHy6OQBktVGi7PoXJnPd1eQzgIzY
         VeaTE7JIV5sx0efetxOLOAvcaQ1b6i9udbjXwK61fY6cGCCCbosOU0IVeIK7rT552860
         CjFg3nOqu5UNCUvJqwAC5B+Wf1WusiB4RKWJJa4DWbL4Yk2qMYKAJuPpGcQPD7GwZOnp
         qlV98/w4yM1fKayulAxEFzdSinS1zb2PpS/6fsFtQjdYfUkQuIOw1PiIqWT4S6XT4mHc
         /X7HvWoh65sc66ugz9i0Rt5i0uo5KICmS/gwz10D+hWbyMz4nefnf9hGdhHaOuAfUwQA
         Towg==
X-Gm-Message-State: APuU4Z95/lPMWicgs7R20d3lLu7MJtDwIbWvtNXzXgXkojepUkkrhuxs
	nZuqZ2tgQzbsLAYCGIzMMTc/EvD684zqnr+TmjwzKq8rl2GXdaQWn8fHdYmk09ngBjEXefpNMqe
	S36oVwrqR
X-Gm-Gg: AZFdTZd6CFfRfTcVRftS4BK1Q2wei4Rf1rBVoVLNu4Ulhef7SNedVaCOwMn9EV+dtfY
	hSSyOZK6cgb7ZqbO6v+ilDT+YadZX9hQNvZQSjqcpfvdLCyW63vIHG2NeVpgP8Avz/Kgs+a59+l
	YXd/Eui+CdZFAlbpYnInJWTpC0hma2G6iXUX2YBhEt+WF2wGfBnvjCKq9o5BRIZrrRGsPzC7JTE
	PGQa4XJQLJfFrsmOgNDxWc64Ki2Y7ZC3bt/rC13qBUirrJpcuVRPIZQssdeY35DbPPCVVu2G/Fx
	bfxpHtVAoWlrhSK91PhEvrNQpyA2Jn/iLq2XKCSIn7NGD762ub8ZsEENF4uT5QoUq0vbh9kWKOY
	ZNgZfMPNdVtfDQ8hdIdiAPY2oYlGyA5uSN2fL4YRcyyp4UIP68tiDJQ9n/qyNAaPX01eLxvoaP1
	Q3DAlXMZYCcckEjejC0QGmqSgpAYxWPeUAbRQKh7QfhP88IZIylln9b326C3FF2FjtxKQq8xmKa
	067ccVLknQ9QWat9cerNG/a8YbtyBYWjHac6BN0SmL09eC7AX1SAVTdyIoAR1FCrF2VaVaQuNl7
	wEpZnMH+UPEYMiZP9NOw5aWgSuVtlmqXQVMkut6UGb/7/GLgmN9RrgfiyTDDMf/V
X-Received: by 2002:a17:90b:1644:b0:3ad:47ce:3876 with SMTP id 98e67ed59e1d1-3b41c9a9cf7mr10724478a91.61.1795460825743;
        Mon, 23 Nov 2026 11:07:05 -0800 (PST)
Received: from localhost (33.79.127.34.bc.googleusercontent.com. [34.127.79.33])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b40578d771sm21961682a91.1.2026.11.23.11.07.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Nov 2026 11:07:04 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 23 Nov 2026 11:07:04 -0800
Message-Id: <DN2TQRX57C04.ZT5UUS6AQ1L6@google.com>
Subject: Re: [PATCH v11 00/13] PCI: liveupdate: PCI core support for Live
 Update
From: "David Matlack" <dmatlack@google.com>
To: "Mike Rapoport" <rppt@kernel.org>, "David Matlack" <dmatlack@google.com>
Cc: <kexec@lists.infradead.org>, <linux-doc@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
 <linux-pci@vger.kernel.org>, "Adithya Jayachandran"
 <ajayachandra@nvidia.com>, "Alexander Graf" <graf@amazon.com>, "Alex
 Williamson" <alex@shazbot.org>, "Alex Williamson"
 <alex.williamson@nvidia.com>, "Bjorn Helgaas" <bhelgaas@google.com>, "Chris
 Down" <chris@chrisdown.name>, "Chris Li" <chrisl@kernel.org>, "David
 Rientjes" <rientjes@google.com>, "Jacob Pan"
 <jacob.pan@linux.microsoft.com>, "Jason Gunthorpe" <jgg@nvidia.com>,
 "Jonathan Corbet" <corbet@lwn.net>, "Josh Hilke" <jrhilke@google.com>,
 "Leon Romanovsky" <leonro@nvidia.com>, "Lukas Wunner" <lukas@wunner.de>,
 "Parav Pandit" <parav@nvidia.com>, "Pasha Tatashin"
 <pasha.tatashin@soleen.com>, "Pranjal Shrivastava" <praan@google.com>,
 "Pratyush Yadav" <pratyush@kernel.org>, "Randy Dunlap"
 <rdunlap@infradead.org>, "Saeed Mahameed" <saeedm@nvidia.com>, "Samiullah
 Khawaja" <skhawaja@google.com>, "Shuah Khan" <skhan@linuxfoundation.org>,
 "Vipin Sharma" <vipinsh@google.com>, "William Tu" <witu@nvidia.com>, "Yi
 Liu" <yi.l.liu@intel.com>
X-Mailer: aerc 0.21.0
References: <20261118223704.3286085-1-dmatlack@google.com>
 <DN0FL1752MH5.1FSZE620OJBM0@google.com> <awKlfqlQYhphXCvf@kernel.org>
In-Reply-To: <awKlfqlQYhphXCvf@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261123_110707_400763_D0486BF0 
X-CRM114-Status: GOOD (  17.65  )
X-Spam-Score: -17.6 (-----------------)
X-BeenThere: kexec@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <kexec.lists.infradead.org>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Sender: "kexec" <kexec-bounces@lists.infradead.org>
X-Spam-Status: No, score=-18.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIMWL_WL_MED,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Sun Nov 22, 2026 at 12:19 AM PST, Mike Rapoport wrote:
> On Fri, Nov 20, 2026 at 03:35:58PM -0800, David Matlack wrote:
>> On Wed Nov 18, 2026 at 2:36 PM PST, David Matlack wrote:
>> > Merge Plan
>> > ----------
>> >
>> > This series is intended to go through liveupdate.git, the tree listed =
in
>> > the new PCI LIVE UPDATE MAINTAINERS entry.
>> >
>> > v10 and a follow-up patch were applied to the lu-pci-preservation bran=
ch
>> > of liveupdate.git. This version is meant to replace them, and applies =
on
>> > v7.4-rc1, the base of that branch.
>>=20
>> Patches 08 and 09 have Reviewed-by tags from Alex now. I have a v12
>> prepped with some small fixes from Sashiko and a comment cleanup from
>> Pranjal.
>>=20
>> Mike do you want me to send a v12 with these changes or send separate
>> fixes for you to apply on top?
>
> Three fixups on top will do. Just please send them as [PATCH] fixup! as a
> reply to what you are fixing up.
> =20

Done. I sent 4 patches, each as a reply to the v11 patch it fixes:

  [PATCH] fixup! PCI: liveupdate: Track incoming preserved PCI devices
  [PATCH] amend! PCI: liveupdate: Adopt ACS controls in incoming preserved =
devices
  [PATCH] fixup! PCI: liveupdate: Adopt ARI Forwarding Enable on preserved =
bridges
  [PATCH] amend! PCI: liveupdate: Freeze preservation status during shutdow=
n

There are 4 instead of 3 because the pci_flb_finish() logging fix from
Sashiko touches a different patch than the other changes.

Two of them are amend! instead of fixup! because they also update the
commit message.

The amend! messages already include your Link: and Signed-off-by:
trailers from lu-pci-preservation, so you may need to drop duplicates if
your tooling adds them again when applying.

After git am and git rebase -i --autosquash on top of
lu-pci-preservation, the result matches the v12 I had prepared.

About the Reviewed-by tags:

 - The amend! for "Adopt ACS controls in incoming preserved devices"
   already includes Pranjal's and Alex's Reviewed-by, so no need to
   pick those up separately (b4 trailers would add them a second time).

 - Pranjal also gave his Reviewed-by on "PCI: Save and restore the ACS
   Control register and Egress Control Vector", which has no fixup, so
   that one needs to be picked up from his reply:

   https://lore.kernel.org/all/awBc0m4oW9nW4hgX@google.com/

Hopefully I did this all correctly... This is my first time sending
in-reply-to fixup! patches.

Thanks.

