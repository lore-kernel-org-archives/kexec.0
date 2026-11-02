Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21346606A5AA
	for <kexec@archiver.kernel.org>; Mon,  2 Nov 2026 17:59:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=zSQ7aAEy;
	dkim=pass (1024-bit key, unprotected) header.d=linux-foundation.org header.i=@linux-foundation.org header.a=rsa-sha256 header.s=google header.b=axXSPiiV
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:Subject:
	Message-ID:Date:From:In-Reply-To:References:MIME-Version:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=/vXXDZI2TLqXD/tqTZGHj/cF0YcMq0fXP1TpWYkM2ME=; b=zSQ7aAEyf9ADCOhzcMf/QhwfZ6
	jpEsyvHjTt2v+3UNwRUavDmIpx/8XHU34gTzNfzmUIu4cWJYtOr7wNJSLLg/zQdxsOs7JS9sdDumQ
	lrE04D9xo+70CYWskTXlkW3MZM73NOSmoOLK0mUf8eqwQgKmfGaJ7uRUZTfVp2TYzOblgjfbPmqGQ
	FnhLNlUSkHgU9bzIr+BP+EwNJCxQFp4D8H3GjrUHwE5iByEt+L9LaAleeq5Hl6W4Rsi9J2s9JZ0oF
	F3J5qk/8hX+chQMtdXF5VD36FUc8B8vtoQKoqzqnO9NGppa7lG4l37c5flDGbh3B7fyMklP2U6SZX
	0DcMYnhQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xNwJT-0000000HXyv-2qb7;
	Mon, 02 Nov 2026 17:59:19 +0000
Received: from mail-ej1-x62f.google.com ([2a00:1450:4864:20::62f])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xNwJP-0000000HXy9-0KEy
	for kexec@lists.infradead.org;
	Mon, 02 Nov 2026 17:59:17 +0000
Received: by mail-ej1-x62f.google.com with SMTP id a640c23a62f3a-c434376dbebso693434866b.1
        for <kexec@lists.infradead.org>; Mon, 02 Nov 2026 09:59:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1793642351; x=1794247151; darn=lists.infradead.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/vXXDZI2TLqXD/tqTZGHj/cF0YcMq0fXP1TpWYkM2ME=;
        b=axXSPiiVCjjfz8zmUMbNQePMZX+9JuOmKD/benzg4VoTdeATAgHnTpzJkwTrBIUYIV
         3njhKapkGb7hJkohZWpdbB83WxLdlV8leA6oVyhJ0GgYRUcr3Mf4JdwHyw3AGdSZuNxG
         yHr1EiaYIJdt9hIOFgwxPbVg6Bja+vb9Y4Tnw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793642351; x=1794247151;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=/vXXDZI2TLqXD/tqTZGHj/cF0YcMq0fXP1TpWYkM2ME=;
        b=r65GFTE9zvsekVJjTafNuqH6ZTpsrc0ul8EsA/agJc3Ny1ojACJSN1wvRsEzC/Dlrk
         6LPcKz2/X9ONbcU+j0cRfs4X3PZ9HBRGheXGrpkhZcm2Iyqhn9zpFg23VwrXxgAG0EX9
         zCZiWVvvQUUuoLqy0/4JPwFqclXWfbl7t0Re5iBPvimAWw2Kdpncz/X73/sfSQrhxFXk
         Z9rQKh2ZzJK96xKX72UEm17wZpWb7HQr4QvYsE+7ihDiaFqYYPiGzi0y+P9MxfnfR8VY
         +gR3pWmaQTiq4QvYAsm+82Eh44xHRFEhoQ3x+8UJKYs7on9vImUig8f5HQqBNNvs6b/w
         /qOQ==
X-Forwarded-Encrypted: i=1; AKwUvBxo6zddTpXt1WItD3HsAmIDOErxzT6AzddaNhU7KzoL8FXmZXXzY4yOCIZ+E6z1G1+7QA+S6w==@lists.infradead.org
X-Gm-Message-State: AFq9FYKzWh5YcZ55CQ3fmiKWJJMRApKMG3VSubG2+jl14dv9ti9a9U78
	vo7VlCHFu2JxWxZVcg3K20kGCP1Uba0ulZD19C48ng3MzRpqcjqZ+Uai9i225lEE96RlnbZuGpR
	xwVLRi9w=
X-Gm-Gg: AYBFou1McmjH3DtTQIypORrH3zczra4zH6n1mgPxvmho1QbAA19dd+Pt563lHaICzad
	zox9QOXCsTnmtk27kU9GLxCau1UQkL9hOQppPvF9dcewCQi6tQgI3fCc3Q8a0XAysIIjj3XPGU6
	TiyRiLz78JRKq+BlcnGYT3CXZLch/SH5UINx4WEhYbVcDJUqdTVt8bfZI/3kyeGgpxnx6t5vf+B
	WD984D9MDafZfPW0xzMAjzCwYhZa12mkQ/YadORJ63aFU+sUQxxPnzP3bnCfu4THZ3tJ3wEGCRu
	9WxER8/fYUc6HFCcSexWT0BsJgXw2j+Hkqg4FLz3uojNUrHcZ/9d3kCpbPpSOwpy5sJq2+wzj7X
	3cWQThX4zCitftrUcPzON4G6/NhBz9K9adrCmwoYYul5q790TbaZZC0eaqDzkfpBg+2tl7bf04B
	IdHn+R78agHdwjrZkCHI8a68VKRlT7c2Ol1kXDe9HD+3d19LRme6wky7iURMNv7bJ6R4XBMkrFE
	YPY6ea0RD+vEZM4oH6xhDKSKQC23qi0iTgoWMByrtjMR0lkqHY6L1h8dOTRdv2FuQ32xQLdgOfk
	/D/TGd6aMqfzNc6siXr/1JEhC9lhJf62Dfw0HAUVy+2vglISqn8cDRl+NuauKl0qkkioHbsmh0B
	tdA==
X-Received: by 2002:a17:907:c24:b0:c2d:d4dd:8d0 with SMTP id a640c23a62f3a-c49d13a80efmr1235562366b.16.1793642351435;
        Mon, 02 Nov 2026 09:59:11 -0800 (PST)
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com. [209.85.208.48])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6b4ec9fcba5sm3717185a12.20.2026.11.02.09.59.08
        for <kexec@lists.infradead.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Nov 2026 09:59:09 -0800 (PST)
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-6b1aa27963eso7716044a12.1
        for <kexec@lists.infradead.org>; Mon, 02 Nov 2026 09:59:08 -0800 (PST)
X-Forwarded-Encrypted: i=1; AKwUvByTIJczEIJKmsMxoHaQxAFwXbsHDBkUvVzX8ZYr+xYpAniY9yg0gnCFG35Yqg2jsgbDWz38hA==@lists.infradead.org
X-Received: by 2002:a17:907:d94:b0:c2d:c80e:8366 with SMTP id
 a640c23a62f3a-c4ca7426f6emr874452266b.0.1793642348398; Mon, 02 Nov 2026
 09:59:08 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261102-work-procfs-bugfixes-v1-0-59422ed3e465@kernel.org> <20261102-work-procfs-bugfixes-v1-1-59422ed3e465@kernel.org>
In-Reply-To: <20261102-work-procfs-bugfixes-v1-1-59422ed3e465@kernel.org>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 2 Nov 2026 09:58:51 -0800
X-Gmail-Original-Message-ID: <CAHk-=wiSA7-mqmAjTQDaU7UjUyWt0TxYwXHafL8ZAPudy+B_uQ@mail.gmail.com>
X-Gm-Features: AclHuK_qZTBVsLQIdymgRHScSFenC6XsGggUDmcuOugjrSTbuVkeASUmC_hYPZo
Message-ID: <CAHk-=wiSA7-mqmAjTQDaU7UjUyWt0TxYwXHafL8ZAPudy+B_uQ@mail.gmail.com>
Subject: Re: [PATCH RFC 01/38] PCI/proc: don't truncate the position of config
 space accesses
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, Jann Horn <jannh@google.com>, 
	Josef Bacik <josef@toxicpanda.com>, Chris Mason <mason@kernel.org>, 
	Jeff Layton <jlayton@kernel.org>, NeilBrown <neil@brown.name>, Eric Dumazet <edumazet@kernel.org>, 
	Thomas Gleixner <tglx@kernel.org>, Al Viro <viro@zeniv.linux.org.uk>, 
	Jonathan Corbet <corbet@lwn.net>, Christoph Hellwig <hch@lst.de>, Greg Kroah-Hartman <gregkh@suse.de>, 
	Joel Granados <joel.granados@kernel.org>, Kees Cook <kees@kernel.org>, Jan Kara <jack@suse.cz>, 
	Jan Kara <jack@suse.com>, linux-kernel@vger.kernel.org, linux-nfs@vger.kernel.org, 
	linux-acpi@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-s390@vger.kernel.org, linux-scsi@vger.kernel.org, 
	linux-um@lists.infradead.org, linux-wireless@vger.kernel.org, 
	linuxppc-dev@lists.ozlabs.org, netdev@vger.kernel.org, ntfs3@lists.linux.dev, 
	platform-driver-x86@vger.kernel.org, coreteam@netfilter.org, 
	kexec@lists.infradead.org, linux-pci@vger.kernel.org, 
	linux-sound@vger.kernel.org, netfilter-devel@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, ibm-acpi-devel@lists.sourceforge.net, 
	jfs-discussion@lists.sourceforge.net, linux-alpha@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-cifs@vger.kernel.org, 
	linux-fbdev@vger.kernel.org, linux-hwmon@vger.kernel.org, linux-mm@kvack.org, 
	linux-sh@vger.kernel.org, linux-usb@vger.kernel.org, 
	samba-technical@lists.samba.org, sparclinux@vger.kernel.org, 
	linux-m68k@lists.linux-m68k.org, linux-doc@vger.kernel.org, 
	linux-serial@vger.kernel.org, linux-atm-general@lists.sourceforge.net, 
	Takashi Iwai <tiwai@suse.de>, linux-input@vger.kernel.org, linux-raid@vger.kernel.org, 
	linux-ext4@vger.kernel.org, linux-modules@vger.kernel.org, 
	linux-debuggers@vger.kernel.org, Chuck Lever <cel@kernel.org>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261102_095915_238284_F61986B8 
X-CRM114-Status: GOOD (  10.89  )
X-Spam-Score: -1.8 (-)
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
X-Spam-Status: No, score=-5.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Mon, 2 Nov 2026 at 06:22, Christian Brauner <brauner@kernel.org> wrote:
>
> proc_bus_pci_write() truncates the file position to an int. A pwrite()
> at an offset like 0xfffff000 turns it negative [..]

I think this would actually be better with rw_verify_area() just
checking a per-file maxbytes.

We already have that logic for lseek and friends - using that fairly
hacky combination of s_maxbytes and !unsigned_offsets().

We should combine s_maxbytes and unsigned_offsets() at file open time
into f_maxbytes and check that not just at lseek but in
rw_verify_area.

And then things like proc_bus_pci could set it's size limit in one single place.

Hmm?

                   Linus

