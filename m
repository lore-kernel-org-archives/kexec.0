Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78DB2C87FDA
	for <kexec@archiver.kernel.org>; Mon, 11 Aug 2025 01:58:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:Subject:
	Message-ID:Date:From:In-Reply-To:References:MIME-Version:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=v5bTWm3eMcCJNfPpUdXPCtKCOZ+9rn+pWDFsHecLhfg=; b=MLs2N+FDdAw/mKVruDxfoeTGNt
	Q6I7acqxCVPcMkmuuHbCPV18e1CXWByz/EVHjHzJCA/ZZP22HTKQS30SkvfLfLIQmBWMxUrUnRexx
	PVj6A7VixfdzBF962dpyFixuJc/KqVRn8l4jStYFyXpD3Prl6SzILTgkJx8H5WYxyVqYBhmY5OiRO
	KyW6lpxCg/m9p5RQzapk+cez7PCNNWrJWBPNOrVwLW1G3RjRxqLrkN48J0b4itoSnFLicDRlVHthB
	S32U8ql4uvjwVE+E5bNSLewNnGrxWMh8Hfk6r/2FiXys3F8cAH2MHni/8Hl98KcIo79p0/UyO1kpg
	C1Ant4+Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ulHne-00000006J6c-3yfZ;
	Mon, 11 Aug 2025 01:58:10 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ulHnc-00000006J6E-2qtb
	for kexec@lists.infradead.org;
	Mon, 11 Aug 2025 01:58:10 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1754877486;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=v5bTWm3eMcCJNfPpUdXPCtKCOZ+9rn+pWDFsHecLhfg=;
	b=WZOUiN5S9QxyGm/oRxWKNugox7DqerSfRw0Ay3vDU3K9nRHhVXMGemfYEa1Z+CC/NStTPt
	ca30UFSe2BxG5gqc8jOfduOgJSAvJaSvSI+a0PMjCp52PCaqDiwWHa4UkvU9ErC0aHlue8
	xC5rpGI8uMy0j7v9gu8wsobV0QezUc4=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-649-nmuNTeHhPviWEzqMkDq1tg-1; Sun, 10 Aug 2025 21:58:04 -0400
X-MC-Unique: nmuNTeHhPviWEzqMkDq1tg-1
X-Mimecast-MFC-AGG-ID: nmuNTeHhPviWEzqMkDq1tg_1754877484
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-4b0791a8e8dso114246921cf.2
        for <kexec@lists.infradead.org>; Sun, 10 Aug 2025 18:58:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754877484; x=1755482284;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=v5bTWm3eMcCJNfPpUdXPCtKCOZ+9rn+pWDFsHecLhfg=;
        b=RXtjc6sYSd3bDyf+V8xWNTFzKI2H/4gU8Kn1LTLnmxCvan17zKV2KS/AZKypb3cH3y
         BE48OcP06+CXMp1i1gDEUeMlaS4x7WMEsi0eijJAGwPp45Do9MRGboEXpdkfGxAZJ62T
         xnd9l5wJC6E3NAceM6TmvWDTPtlqzHbEF8ofJpiXugsargygel/wzVNaDUbfK/TI9fRJ
         Czkm8Tn/jdfMlBnXNPV8tdzlfqB6lvPfOO5wgfIVTBTtTq7FX0etgyFN9cw3fVqmi4KX
         DNk7+F88iLjI5fhyjW6qZT/DkcFmzhV360GGbIoKNf5U8cpY7asLMSSR+4VkHsRJEsH2
         imNA==
X-Forwarded-Encrypted: i=1; AJvYcCX2Lz1pVrWjzIubTZOyJycPavusLb7hqHAT+e7g+QlSzzOs8VJJqXmtc87CMqPAAzlJyQpmwA==@lists.infradead.org
X-Gm-Message-State: AOJu0Yx7X2dWVzDlp0ffPgblujjP/kZTFaTe316VylsU6pXX/IE6kbb4
	7bKCjBquxPCEZBkLP6A6m1h731VszOABZgWT9tjaK6T62EWYS0Lc+rI5QNhrSyGOrLzMEjqNdca
	1YM4Jof6kMkzWiZtWqPS9upSbqWg2tr6aXO8jXp9YAqTOamZrhD9cnW7Y6zKBW/yjTzpcfMJzEe
	GmtAISBZ22w00ZDvxX+VVfqG1eoUfcku6nQeP7
X-Gm-Gg: ASbGncug1bo7lU4P4rLjDKwLInkrQZlDFA3mdxP3PWF0FUhZClT6uI6nvZezLWLR47d
	vjEEfGgAKzoVhzJvchvVBtYPzxqzd0wU1YN2HSUqVtkQDRTxNGCGwgDmifamRpaVA5LNTZ3tij1
	zxXHEt7V0yycIhruJ7WeN88HBBgb1xfbmj2kaYAJIKTmBkfFXsaQ6D
X-Received: by 2002:ac8:5988:0:b0:4b0:7738:6496 with SMTP id d75a77b69052e-4b0aed86229mr173763711cf.60.1754877483918;
        Sun, 10 Aug 2025 18:58:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGLQpsjqmqq6RuxtLSN64JW130ilpQcc55dHUjLQGR+sxe3gWBYutbI5uLidVi8iaaKE3hpUxvaupQrb5R7qPQ=
X-Received: by 2002:ac8:5988:0:b0:4b0:7738:6496 with SMTP id
 d75a77b69052e-4b0aed86229mr173763581cf.60.1754877483586; Sun, 10 Aug 2025
 18:58:03 -0700 (PDT)
MIME-Version: 1.0
References: <20250808015134.2875430-2-lichliu@redhat.com> <CALu+AoTGwZqB28Z+sJ4KW7esNHx8=5kJ6nrMpoQ_rogzSDGwxA@mail.gmail.com>
 <CALu+AoTGY0wKubVgR_EF5BZmYvh180fjP1AsLvp8cJ447WFGaA@mail.gmail.com> <68c086ce-64a0-41e7-8c95-5252dceba0b4@landley.net>
In-Reply-To: <68c086ce-64a0-41e7-8c95-5252dceba0b4@landley.net>
From: Lichen Liu <lichliu@redhat.com>
Date: Mon, 11 Aug 2025 09:57:52 +0800
X-Gm-Features: Ac12FXzAUfAnBIAIIk6KaLMx7WY-GkMs_s30M6F6RbdwVvRQPl3gAlbci-uLHB8
Message-ID: <CAPmSd0M2A7NNODWvsvu5sU85mbRVjPYam1v7pbj3tSx073w+XQ@mail.gmail.com>
Subject: Re: [PATCH] fs: Add 'rootfsflags' to set rootfs mount options
To: Rob Landley <rob@landley.net>
Cc: Dave Young <dyoung@redhat.com>, viro@zeniv.linux.org.uk, brauner@kernel.org, 
	kexec@lists.infradead.org, linux-kernel@vger.kernel.org, 
	weilongchen@huawei.com
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: ubnx_fAEURXv1B_Uw07IUsBThSF1MIje1PpI7QCWwXg_1754877484
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250810_185808_799918_05443EC4 
X-CRM114-Status: UNSURE (   7.26  )
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
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

Hi Rob,

Thanks for your help with testing and for answering Dave's question in detail!

Your "history time" here is fantastic and explains the reasoning
perfectly, it is very interesting and I believe it could be part of a
publication.

Based on this discussion, it seems the patch is heading in the right
direction. Please let me know if there are any other concerns.

Thanks!
Lichen


