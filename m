Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 086EDCA0EE4
	for <kexec@archiver.kernel.org>; Sat, 16 Aug 2025 04:50:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=BNvSs17H30Pojr0mYh58UbN4qSdGEsmKv1b+WURr28o=; b=EERlusxS+XW4kHbKafWIXYkG/0
	Rx1HW91ZiwKdTQd4rxbsxYl+5NBjQvi5U/yCnV/SYkv5Gr3skt/AXxhwgv+clbRJDdJpsUI0BeYBO
	WVvWQFQt6eAIZ3QG/u8SiDig5nzauDofYzueIcGKt+4Pbv/tsuEsMMgQm40xyWkWky8N2VfinCoSb
	F9+EohMwwNggS9H4h01OW1VV+mrPBtqquS1+mczl+aEwyajB4fxmDEtbWwSslwknMN/x35DQTWVHV
	cIuMr2HifAkWmhjjKm99AcgwSJsVaIs0R5icNIWYUsEfBrTEYOA+HevKMVNVfHK3xyd6DUuecqYvw
	7HkDkxoA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1un8s1-000000043w8-3UZZ;
	Sat, 16 Aug 2025 04:50:21 +0000
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1un8rz-000000043vk-0TWj
	for kexec@lists.infradead.org;
	Sat, 16 Aug 2025 04:50:20 +0000
Received: by mail-wr1-x42c.google.com with SMTP id ffacd0b85a97d-3b9d41c1149so1890272f8f.0
        for <kexec@lists.infradead.org>; Fri, 15 Aug 2025 21:50:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755319817; x=1755924617; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BNvSs17H30Pojr0mYh58UbN4qSdGEsmKv1b+WURr28o=;
        b=Ea3rlg846CauXeucEYYTZLlBm2dB6jHrwEwHxR1EFR5KSTtnVWtVCW7c1hOSNd6syI
         7Y+zGnOl+R2vQxbYuoKlfT+91ANp+ZgySZtAG4tjZNO5bnbytEsqlipVEsvYGn/jHjxu
         vWhg7pD2QK5+mLjW4FNd18xDnLQggpF2dELR9DK9NN4xkmspFW9PZAWCM7KvOJ7tpV22
         yNktATbteiGg1QX3jT4QkV5TsWWSofCFuQ5OACEEw5ZMQZeGW1/TnTGdymyuN33gGoD1
         CG0T5EUo7PTyD5V/Dr2R78p4oDyrBQANWCO5qUCv8XtZ/ubGFVyvRZzCRglGNpPq75T6
         5Kfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755319817; x=1755924617;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BNvSs17H30Pojr0mYh58UbN4qSdGEsmKv1b+WURr28o=;
        b=teRucTUaT+/KVk5MeFUgp/6BOlxdJwEZmKGj6luL1bXj32gKxgwmEqhq0CqBmj2VYn
         jxTJXUp5JTA3NaHTR/HKza2vT2kqSctJpWuw0+b+57n8cU7FUUnFtxvS8CG+cb5npmrs
         HmNUm4pLA9TVcbsG1Bz2FrGc/cHD2k+23JDk7BhfLEHqK+d2kM71F4KcOZiE88v2UmIi
         8Wl7faHxvKlHwaIKOhgJXBJuj88GUleusUvykpAQnqi2BapqnrHA87607ccfT6OgY3Z5
         qKLkNo0U5VoQJlMVmEvCgkLy69eARqiFySc2lrP/3RJaS50toXCV18VaMZKP+s+/kbvC
         8/Bg==
X-Forwarded-Encrypted: i=1; AJvYcCW8hfQFDhv6UW2J2254hmbED9hLepOG0rL0OWkJJhL+W0CDFAigvBtzhYNbxXbgDRpIIdco6g==@lists.infradead.org
X-Gm-Message-State: AOJu0YzkCPXEX3h7KbqwGt5Zo52359F9kf5WTd33Fhhjail9IRp1G9Az
	SOih8XFREP42CXLunvC+lKGHmcrh0JEWOiHkLo54Oo/nVnEcNFJ8efviPo3ZmyayGyroLga0BsL
	8FgF6RGDJVjaHNUsGetU47EMFHnW7+00=
X-Gm-Gg: ASbGncsOmy6MlvUy2ue+1MvEENYkMNYYcE1Zc+4HurR80hefXQIkJZq1xe2biqMELsk
	8JEmqFWejQnhDnTAYwp0rVrK5GUkbjpfI/5GXBnhIGgFs2yV4hr11yXhbSwgqfrrk4blycaV4uU
	ELdCxOlSgFpM5aSQiIZI9SpqVet6WS0Z1f5IDx25uv69gUbVdW82TiWL6wwNy80YLFa/r2CuEjI
	u3E4RPb
X-Google-Smtp-Source: AGHT+IFPvY8ec5Jn5OTlpsBfvFYtAsonj3tCEjtnK0os5EQlDMqmiyj8gQxFAf5K2RSyQc73thlVSiKnZ0ALE9aWQug=
X-Received: by 2002:a05:6000:200e:b0:3b7:735f:25c9 with SMTP id
 ffacd0b85a97d-3bb67100411mr3698495f8f.21.1755319817249; Fri, 15 Aug 2025
 21:50:17 -0700 (PDT)
MIME-Version: 1.0
References: <20250812124941.69508-1-bhe@redhat.com> <CA+fCnZcAa62uXqnUwxFmDYh1xPqKBOQqOT55kU8iY_pgQg2+NA@mail.gmail.com>
 <CA+fCnZdKy-AQr+L3w=gfaw9EnFvKd0Gz4LtAZciYDP_SiWrL2A@mail.gmail.com>
 <aJxzehJYKez5Q1v2@MiWiFi-R3L-srv> <CA+fCnZfv9sbHuRVy8G9QdbKaaeO-Vguf7b2Atc5WXEs+uJx0YQ@mail.gmail.com>
 <aJ2kpEVB4Anyyo/K@MiWiFi-R3L-srv>
In-Reply-To: <aJ2kpEVB4Anyyo/K@MiWiFi-R3L-srv>
From: Andrey Konovalov <andreyknvl@gmail.com>
Date: Sat, 16 Aug 2025 06:50:06 +0200
X-Gm-Features: Ac12FXxYLTsqomvoG9UG93Lotus4fuW2rcu_NxDqALVSquB40p2BNceICCGi8q4
Message-ID: <CA+fCnZcdSDEZvRSxEnogBMCFg1f-PK7PKx0KB_1SA0saY6-21g@mail.gmail.com>
Subject: Re: [PATCH v2 00/12] mm/kasan: make kasan=on|off work for all three modes
To: Baoquan He <bhe@redhat.com>
Cc: linux-mm@kvack.org, ryabinin.a.a@gmail.com, glider@google.com, 
	dvyukov@google.com, vincenzo.frascino@arm.com, akpm@linux-foundation.org, 
	kasan-dev@googlegroups.com, linux-kernel@vger.kernel.org, 
	kexec@lists.infradead.org, sj@kernel.org, lorenzo.stoakes@oracle.com, 
	elver@google.com, snovitoll@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250815_215019_157310_7F5D14B9 
X-CRM114-Status: GOOD (  13.58  )
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

On Thu, Aug 14, 2025 at 10:56=E2=80=AFAM Baoquan He <bhe@redhat.com> wrote:
>
> Ah, I got what you mean. We probably are saying different things.
>
> In order to record memory content of a corrupted kernel, we need reserve
> a memory region during bootup of a normal kernel (usually called 1st
> kernel) via kernel parameter crashkernel=3DnMB in advance. Then load
> kernel into the crashkernel memory region, that means the region is not
> usable for 1st kernel. When 1st kernel collapsed, we stop the 1st kernel
> cpu/irq and warmly switch to the loaded kernel in the crashkernel memory
> region (usually called kdump kernel). In kdump kernel, it boots up and
> enable necessary features to read out the 1st kernel's memory content,
> we usually use user space tool like makeudmpfile to filter out unwanted
> memory content.
>
> So this patchset intends to disable KASAN to decrease the crashkernel
> meomry value because crashkernel is not usable for 1st kernel. As for
> shadow memory of 1st kernel, we need recognize it and filter it away
> in makedumpfile.

Ah, I see, thank you for the explanation!

So kdump kernel runs with the amount of RAM specified by crashkernel=3D.
And KASAN's shadow memory increases RAM usage, which means
crashkernel=3D needs to be set to a higher value for KASAN kernels. Is
my understanding of the problem correct?

