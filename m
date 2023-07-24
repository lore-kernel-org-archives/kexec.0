Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2DF5BC001DE
	for <kexec@archiver.kernel.org>; Mon, 24 Jul 2023 08:44:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:From:References:Cc:To:Subject:
	MIME-Version:Date:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Hj/AV+cj4IF4DHqdDWVOnlQY3y5qR0UqeaQIovYV/VM=; b=z36leKm7zkJSA5
	q/mhUN46GAd3UPatd6igUgJaG0n8TogUFb/QdmoJbkf9dv44XTwxdvbwXBm6lK63+RjAY9Y9wsU1x
	QGw6Z3jhUlJOSkFIdqgSkfJAqoPIAEDPw9HMKA8Jz5G4+Ci09MJpuuUxhNbgb9E0YM0J3Wo0H3LG1
	HMrjpDOpwh3l9oUQxvtgqP8dQaNO+e3DuAwwH76VAeNN9Pfjub+slTwRLVekZNLE/BCiEAEOdiANd
	L7zWP/o0uebxSMjegmtM9J2chXbJreuqa2RQghAa7SV+1ZofTy7zMokgmlJ/kkUU8zF++vR5YiByP
	y1oXIpBSe2ldd7vW2jLw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qNrB6-003HzP-25;
	Mon, 24 Jul 2023 08:44:28 +0000
Received: from mail-oi1-x230.google.com ([2607:f8b0:4864:20::230])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qNrB2-003HyV-0q;
	Mon, 24 Jul 2023 08:44:25 +0000
Received: by mail-oi1-x230.google.com with SMTP id 5614622812f47-3a3373211a1so2456578b6e.0;
        Mon, 24 Jul 2023 01:44:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690188261; x=1690793061;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P0N0+l5LuHnOQAsHz1qcvo710sueGtkCqDZuXqqG1pw=;
        b=TNpkIN5YLv3ScClvOFTYK5TFIoexXAEhqRxCjo3BtfihDiTs8wn9B2zPhxXFW4W/Xw
         yC8hhWiD3mpm7KFzOzXUJapqHz5g8BSPcdAQQKaLgDZqo+eOHCN0Z7ffM/r/3LmoM5KA
         AXLrbipXXEet/uBhca3nOfFFIPbDd7/MH9ryX0Fi1BM5A/tE2j6FgVOb0aGbwaGrFKL8
         SHzb8bciY9Q+LVz6Z+Mfm3e+5gJ/XpPAEkAZy8aGfPH9cMOcBynOcnfZYmZEfBs+smLH
         a//1n8LwVrt2Y2EI9voyeM/TozU2g16mcay5qI8R15tlh3on7j0fdy6qYDCk4GkCfPhJ
         gf9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690188261; x=1690793061;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=P0N0+l5LuHnOQAsHz1qcvo710sueGtkCqDZuXqqG1pw=;
        b=kqJQ27yCQkkK+IFua0S28fMxDhudSxPKWDVEOBDE81YxNGzps4KbORmWV6kkA5fmBb
         ktM2oTXN0n6+IdE+emO6oNBcy/Zb5zn9ODIbi37OMn3eYUNZk3A5G2ESJDfsyFzlu87R
         PUh9JxL3d4OyHcgRrX5OSw2yzv4kOwL147NSTt8Zbwgp+6BJ3ftNxbWvxKe+4SKJl6Lb
         mzKr0PVNOr+FMZy8aUw5MZOPzyYYn1UzItOXt+npOFXTlpXdUbG9Hsa5ISJTLnAvopna
         NFvz2Nca/jI+IUPZeqxDrRLJcYHTjUpOqQ5W+nYYU4plwTZ1sE0vhLsHhzQ12AKxc7sI
         u2/g==
X-Gm-Message-State: ABy/qLYwnWQ+gKTveSRtF0E6y4heLLvPFPAV9fPQ0gtWH1H/aLw29+cV
	5wE/cKgdBBPzN/dB8JyoEns=
X-Google-Smtp-Source: APBJJlFuxmpkv3fxS4EWnyR30WmuYlgm0mSf3fvjnFhITUg1oq1VXZMwyDPSA0+1nEpCi+rqnemcEw==
X-Received: by 2002:a05:6358:262a:b0:134:cbff:c5a4 with SMTP id l42-20020a056358262a00b00134cbffc5a4mr5394711rwc.18.1690188260734;
        Mon, 24 Jul 2023 01:44:20 -0700 (PDT)
Received: from [0.0.0.0] ([5.180.77.117])
        by smtp.gmail.com with ESMTPSA id x22-20020aa784d6000000b0066a6059d399sm7190092pfn.116.2023.07.24.01.44.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Jul 2023 01:44:20 -0700 (PDT)
Message-ID: <855df973-4f4b-6fff-a228-c1af80c14db0@gmail.com>
Date: Mon, 24 Jul 2023 16:44:12 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [Crash-utility] RISCV64: Use va_kernel_pa_offset in VTOP()
To: Conor Dooley <conor.dooley@microchip.com>
Cc: xianting.tian@linux.alibaba.com, mick@ics.forth.gr,
 heinrich.schuchardt@canonical.com, guoren@kernel.org, k-hagio-ab@nec.com,
 yixun.lan@gmail.com, lijiang@redhat.com, linux-riscv@lists.infradead.org,
 kexec@lists.infradead.org, crash-utility@redhat.com, alex@ghiti.fr
References: <20230724040649.220279-1-suagrfillet@gmail.com>
 <20230724-sandpaper-raving-9ad883223e6d@wendy>
From: Song Shuai <suagrfillet@gmail.com>
In-Reply-To: <20230724-sandpaper-raving-9ad883223e6d@wendy>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230724_014424_316210_1A11FFB1 
X-CRM114-Status: GOOD (  14.63  )
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
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

CgrlnKggMjAyMy83LzI0IDE1OjQxLCBDb25vciBEb29sZXkg5YaZ6YGTOgo+IEhleSwKPiAKPiBP
biBNb24sIEp1bCAyNCwgMjAyMyBhdCAxMjowNjo0OVBNICswODAwLCBTb25nIFNodWFpIHdyb3Rl
Ogo+PiBTaW5jZSBSSVNDLVYgTGludXggdjYuNCwgdGhlIGNvbW1pdCAzMzM1MDY4Zjg3MjEgKCJy
aXNjdjogVXNlCj4+IFBVRC9QNEQvUEdEIHBhZ2VzIGZvciB0aGUgbGluZWFyIG1hcHBpbmciKSBj
aGFuZ2VzIHRoZQo+PiBwaHlzX3JhbV9iYXNlIGZyb20gdGhlIGtlcm5lbF9tYXAucGh5c19hZGRy
IHRvIHRoZSBzdGFydCBvZiBEUkFNLgo+Pgo+PiBUaGUgQ3Jhc2gncyBWVE9QKCkgc3RpbGwgdXNl
cyBwaHlzX3JhbV9iYXNlIGFuZCBrZXJuZWxfbWFwLnZpcnRfYWRkcgo+PiB0byB0cmFuc2xhdGUg
a2VybmVsIHZpcnR1YWwgYWRkcmVzcywgdGhhdCBtYWRlIENyYXNoIGJvb3QgZmFpbGVkIHdpdGgK
Pj4gTGludXggdjYuNCBhbmQgbGF0ZXIgdmVyc2lvbi4KPj4KPj4gTGV0IExpbnV4IGV4cG9ydCBr
ZXJuZWxfbWFwLnZhX2tlcm5lbF9wYV9vZmZzZXQgaW4gdjYuNSBhbmQgQ3Jhc2ggY2FuCj4+IHVz
ZSAidmFfa2VybmVsX3BhX29mZnNldCIgdG8gdHJhbnNsYXRlIHRoZSBrZXJuZWwgdmlydHVhbCBh
ZGRyZXNzIGluCj4+IFZUT1AoKSBjb3JyZWN0bHkuCj4+Cj4+IFNpZ25lZC1vZmYtYnk6IFNvbmcg
U2h1YWkgPHN1YWdyZmlsbGV0QGdtYWlsLmNvbT4KPj4gLS0tCj4+IFlvdSBjYW4gY2hlY2svdGVz
dCB0aGUgTGludXggY2hhbmdlcyBmcm9tIHRoaXMgbGluazoKPj4gaHR0cHM6Ly9naXRodWIuY29t
L3N1Z2FyZmlsbGV0L2xpbnV4L2NvbW1pdHMvNi41LXJjMy1jcmFzaAo+Pgo+PiBBbmQgSSdsbCBz
ZW5kIHRoZSBMaW51eCBjaGFuZ2VzIHRvIHJpc2N2L2Zvci1uZXh0IElmIHlvdSdyZSBvayB3aXRo
IHRoaXMgcGF0Y2guCj4gCj4gSWYgeW91IHdhbnQgdGhpcyB0byBnbyBpbnRvIDYuNSwgeW91J2xs
IG5lZWQgdG8gc2VuZCBpdCBmb3IgcmlzY3YvZml4ZXMKPiBpbnN0ZWFkLiBJdCBzb3VuZHMgbGlr
ZSBhIGZpeCBmb3IgdGhpcyB3b3VsZCBuZWVkIHRvIGdvIGludG8gNi40IHRvbywKPiBubz8KWW91
J3JlIHJpZ2h0LCB0aGF0IHNob3VsZCBiZSByaXNjdi9maXhlcyBmb3IgNi41IGFuZCB0aGlzIGlz
c3VlIGFsc28gCm5lZWQgdG8gYmUgZml4ZWQgaW4gNi40IHN0YWJsZS4KCkhvdyBhYm91dCB3YWl0
aW5nIGZvciBDcmFzaCBndXlzJyBjb21tZW50cyBvbiB0aGUgaW50cm9kdWN0aW9uIG9mIHRoZSAK
InZhX2tlcm5lbF9wYV9vZmZzZXQiIGluIHZtY29yZWluZm8KYW5kIHRoZW4gZGV0ZXJtaW5lIHdo
aWNoIHN0YWJsZSB2ZXJzaW9uIHNob3VsZCBiZSB0YWtlbiBpbiB0aGUgZmlyc3QgCiJpZiIgb2Yg
a2VybmVsX3ZlcnNpb24uCj4gCgotLSAKVGhhbmtzClNvbmcgU2h1YWkKCl9fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmtleGVjIG1haWxpbmcgbGlzdAprZXhl
Y0BsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4v
bGlzdGluZm8va2V4ZWMK
