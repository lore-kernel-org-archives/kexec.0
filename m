Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7605BCE7B0C
	for <kexec@archiver.kernel.org>; Thu, 28 Sep 2023 08:52:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:References
	:In-Reply-To:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=ygpq1GzDZrr7svhSeg167FX/NtAQuOleNgyKWbr0aJQ=; b=l/tqm7p7jbyjrv
	drP3GQ+dPZZ7HosaQOQpbxK7XkTLip7e5d8LpyD20/EKw3a6GZntg2/0S98Wf0lVL9+kaDYm9D1TM
	jl0yCpGA258ETaYBWJx1kJIM7Vjw1Dwxg0WUDRHJO8S/dL19l2cZpJEmCZt/ejI6Z2VeQxQH8uQBo
	2v0BraxnrAoNawzA/8PyTroBKeiHHmn3N2AZqGtklmnhn3u/puPyNL64KvlMh3+T+zLqqln3d9qg5
	jWBoSppPgc7ChtNS+WARoshbmzZGtMVVFCtzLmdbn5cxKU0/kNBqFgJT57s2Nd6NKNKmCmbuK+UDP
	JXDXzXDs4S7fl94OYU2A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qlmkY-002ezJ-0H;
	Thu, 28 Sep 2023 08:51:58 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qlmkT-002eyp-1u
	for kexec@lists.infradead.org;
	Thu, 28 Sep 2023 08:51:54 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1695891111;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=NkWcflk7o2IhAoW5ugdA3P4TxFldRrvEEsOTDIfjw5E=;
	b=LlGrtTweUgG0Mw1ZuDKwRx8D7xFVIg6oVj3O+e95APmwxe6xcv1w9hg214uuzQL5SQdVBN
	zRicWYE675AhbXkHfWzwNFX9YBFwBSdpHeEPGD7hjqhZYN/vqlhPalvfm+Enadsjzci+2A
	3XvrpccJqYtfjFlLVg3i6HWHZCNmMe4=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-651-3X3ecwYdPK68KfGIWFfMpg-1; Thu, 28 Sep 2023 04:51:49 -0400
X-MC-Unique: 3X3ecwYdPK68KfGIWFfMpg-1
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-418225fb5d6so113969871cf.3
        for <kexec@lists.infradead.org>; Thu, 28 Sep 2023 01:51:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695891109; x=1696495909;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NkWcflk7o2IhAoW5ugdA3P4TxFldRrvEEsOTDIfjw5E=;
        b=ssc8DsR7R27Wjn7eq47v0l+M+SS4QtFa00FcwQyfYPRp2NpRmp0BPLKnTGhXunbMpW
         fYyq6ivIv9MX7/2XVn5b8cLByYqE6LAYwAVeJ/UFBuV0Zewt69DKKUE2uUaeh80wL1gb
         DrmwCmFUtKzq3NZrdghqOEGh2+CDu9JlzTHlN5aACjKfiUm4gSki/baEa8vU22mCANVp
         w4WkoWDiZ7VRxGnfFdeCD4bnXfoSpW3cZXZVhyo6Hcyvu9KKfzSgt4Wt/c2Y28uzyqsB
         UTgXX9TU+vtAp71OAmEJF3Gw2Ay5eYMUcfU685OZSQc+Ck+FUV26EXzmyfCJ/60hce+N
         sPGQ==
X-Gm-Message-State: AOJu0YxFDHM5TMk13VLzhM4ApJpd/+mlrcgL3C1ibeHEqQJmUI16AXj6
	4VwTHub2AC7jtBaLad0HEvjcxhoHvjkLaZYgEukWy0r5RESvov/xpNawMVJhgAqWzbjoedI1wLb
	BxqRZQVHkEzT7O76EwzVGBcZ8Zv+0
X-Received: by 2002:a05:622a:138b:b0:412:191c:ffa with SMTP id o11-20020a05622a138b00b00412191c0ffamr637756qtk.26.1695891109113;
        Thu, 28 Sep 2023 01:51:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE+H2XpyC6g5cXAzUKMgVxYhAIA1uZrXD5jkN2vZZOVsLgR0f4SYCEkiNop7wfk3UqIpQAm2g==
X-Received: by 2002:a05:622a:138b:b0:412:191c:ffa with SMTP id o11-20020a05622a138b00b00412191c0ffamr637746qtk.26.1695891108882;
        Thu, 28 Sep 2023 01:51:48 -0700 (PDT)
Received: from vschneid.remote.csb ([80.215.217.124])
        by smtp.gmail.com with ESMTPSA id ig8-20020a05622a6a4800b004181127a230sm3614173qtb.76.2023.09.28.01.51.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Sep 2023 01:51:48 -0700 (PDT)
From: Valentin Schneider <vschneid@redhat.com>
To: Baoquan He <bhe@redhat.com>, linux-kernel@vger.kernel.org
Cc: kexec@lists.infradead.org, akpm@linux-foundation.org,
 eric.devolder@oracle.com, sourabhjain@linux.ibm.com, Baoquan He
 <bhe@redhat.com>
Subject: Re: [PATCH v3] Crash: add lock to serialize crash hotplug handling
In-Reply-To: <20230926120905.392903-1-bhe@redhat.com>
References: <20230926120905.392903-1-bhe@redhat.com>
Date: Thu, 28 Sep 2023 10:51:45 +0200
Message-ID: <xhsmhy1gqu1cu.mognet@vschneid.remote.csb>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230928_015153_706126_79AE2518 
X-CRM114-Status: UNSURE (   9.06  )
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

On 26/09/23 20:09, Baoquan He wrote:
> Eric reported that handling corresponding crash hotplug event can be
> failed easily when many memory hotplug event are notified in a short
> period. They failed because failing to take __kexec_lock.
>
> =======
> [   78.714569] Fallback order for Node 0: 0
> [   78.714575] Built 1 zonelists, mobility grouping on.  Total pages: 1817886
> [   78.717133] Policy zone: Normal
> [   78.724423] crash hp: kexec_trylock() failed, elfcorehdr may be inaccurate
> [   78.727207] crash hp: kexec_trylock() failed, elfcorehdr may be inaccurate
> [   80.056643] PEFILE: Unsigned PE binary
> =======
>
> The memory hotplug events are notified very quickly and very many,
> while the handling of crash hotplug is much slower relatively. So the
> atomic variable __kexec_lock and kexec_trylock() can't guarantee the
> serialization of crash hotplug handling.
>
> Here, add a new mutex lock __crash_hotplug_lock to serialize crash
> hotplug handling specifically. This doesn't impact the usage of
> __kexec_lock.
>
> Signed-off-by: Baoquan He <bhe@redhat.com>

Reviewed-by: Valentin Schneider <vschneid@redhat.com>


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
