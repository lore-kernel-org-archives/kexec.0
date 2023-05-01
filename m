Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 820A7C77B61
	for <kexec@archiver.kernel.org>; Mon,  1 May 2023 16:19:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Cc:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=ryB5g4E4w+W/fHmFzTa6qGXS17UDcc+kDJrRdYZr+10=; b=rB55bA4Hrc9Vr3
	LBMtSLOmSC6PMYAe+ydCCPwxjKJvxHdbEaUrV8tQjTxLVcxA2XcU0EKtFlr4kQvwL76rNw0LUm/yj
	ScaqXN1xzeVU6/sjhznamPvxCBJRM2WICclNasuFLljzTjCd30I0NA9uc4siXOdq2jKe36jFU0Lyh
	Xvm16B75xK9YR3L0+gtyo/EvcYBOaCZmelexv2c1llYG5ZwFSlQFAtT4e+VVOD9W7+hgzs/Lblx7C
	6RY1sz7l63OEcTCaNhj6w01wFTU1P1xM3iDsK94BEVFSL+OXmtFqdobKQk7iPJRUWcSKHxaA3PzIF
	Qq+Um3DnKI699h/BosOg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1ptWFM-00GIgy-0H;
	Mon, 01 May 2023 16:19:28 +0000
Received: from mail-pf1-x434.google.com ([2607:f8b0:4864:20::434])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1ptWFJ-00GIfA-28
	for kexec@lists.infradead.org;
	Mon, 01 May 2023 16:19:26 +0000
Received: by mail-pf1-x434.google.com with SMTP id d2e1a72fcca58-642f5394651so245389b3a.3
        for <kexec@lists.infradead.org>; Mon, 01 May 2023 09:19:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1682957962; x=1685549962;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4FGuwB8DZaGL5fmexOM8fuvxUhs14V0EADfy1lJEIKY=;
        b=Nyhxg6KoMv5DCAGM6mCPXn6ItenAW7c9QV20p31a0qYhzUuuPPWSPWIEunfg7MZGBX
         hvbJsvBo3U58pWAw2c/kzLOQD9kLiPrO9QMsDd8VQrqPikgs1wq+zpmPFHQoHQQ569Cy
         oTOiyB6hPuBk4CiO6pz8Fe2zoWRqemoOGGEzUT+dk/zKc6lKhWSQ7lhp4GHBG4Kyt+eU
         OH3MEzklYYBX4u7sk6s8IPDnNBCU1hsEL08Nv2qA8Hvoi+GhrZ2f+H+kkWkLB8XpVuRY
         CBn0WlzlKP0alqt8rt8XACki8K5zYFOz2BaMXAdhGnP35ait50bb1lKSXSTzcVMgF/gW
         gP5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682957962; x=1685549962;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4FGuwB8DZaGL5fmexOM8fuvxUhs14V0EADfy1lJEIKY=;
        b=Z7dGQvDySTDllDE3MmgwDYyOXAmD17VM1wP8lTBxaE5aBLlaJZ1XhdFHh7gynVziPR
         lXYPnhd3eVLrwR0k3FhgW4AD7OZyLNK2+xrOMdG5KsL4l1ataOqndd8VCnSeUG/untmZ
         /5UG5RQxbuGRP1YSpLq8cPloD4ZmzSBIH7lBMCHL06f8bwmTRaX4Bjfv+vgdZAk/42wS
         QbiopRXmcjdMOx2A/RudZYKseNftDJvckLkDrcREhG1M1PUTHUkq3J9ssipfP3oADZdD
         KqSrvAUTBeLLm8sJCB+oPlxQsh14XbYt0DOmDkjdKR7ii8ooIvwY7lTPqmqBvb2YBXQr
         pFwA==
X-Gm-Message-State: AC+VfDxeodLSbWwcZ7UdYNe8/+mGDyEfTxCG6PFbiQ/z1z3oRMb+SPN+
	VrbELY9et4q2cBXklnJTaMCkUttH/MnlUoAn37Wylw==
X-Google-Smtp-Source: ACHHUZ6RwItANJ/R5G0kwGBHYfYxEFLhUkM0VFd5rJeaVtkIhzWcYIQu18UznRkT5L5a5Vr226WpFX8ruirZ7cWLUO8=
X-Received: by 2002:a05:6a20:1588:b0:f9:1f3e:cccb with SMTP id
 h8-20020a056a20158800b000f91f3ecccbmr17087658pzj.10.1682957961585; Mon, 01
 May 2023 09:19:21 -0700 (PDT)
MIME-Version: 1.0
References: <20230321-kexec_clang16-v6-0-a2255e81ab45@chromium.org> <20230321-kexec_clang16-v6-4-a2255e81ab45@chromium.org>
In-Reply-To: <20230321-kexec_clang16-v6-4-a2255e81ab45@chromium.org>
From: Nick Desaulniers <ndesaulniers@google.com>
Date: Mon, 1 May 2023 09:19:10 -0700
Message-ID: <CAKwvOd=9RMivtkKX27nDDsagH5yCWjpAOvpE2uaW38KYC57vtg@mail.gmail.com>
Subject: Re: [PATCH v6 4/4] risc/purgatory: Add linker script
To: Ricardo Ribalda <ribalda@chromium.org>
Cc: Eric Biederman <ebiederm@xmission.com>, Philipp Rudo <prudo@linux.vnet.ibm.com>, 
	Dave Young <dyoung@redhat.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, Nathan Chancellor <nathan@kernel.org>, Tom Rix <trix@redhat.com>, 
	Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, 
	Christophe Leroy <christophe.leroy@csgroup.eu>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, Baoquan He <bhe@redhat.com>, 
	Philipp Rudo <prudo@redhat.com>, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, 
	Ross Zwisler <zwisler@google.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Simon Horman <horms@kernel.org>, llvm@lists.linux.dev, linuxppc-dev@lists.ozlabs.org, 
	linux-riscv@lists.infradead.org, stable@vger.kernel.org
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230501_091925_721334_6E5D8F5F 
X-CRM114-Status: GOOD (  18.65  )
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

T24gTW9uLCBNYXkgMSwgMjAyMyBhdCA1OjM54oCvQU0gUmljYXJkbyBSaWJhbGRhIDxyaWJhbGRh
QGNocm9taXVtLm9yZz4gd3JvdGU6Cj4KPiBJZiBQR08gaXMgZW5hYmxlZCwgdGhlIHB1cmdhdG9y
eSBlbmRzIHVwIHdpdGggbXVsdGlwbGUgLnRleHQgc2VjdGlvbnMuCj4gVGhpcyBpcyBub3Qgc3Vw
cG9ydGVkIGJ5IGtleGVjIGFuZCBjcmFzaGVzIHRoZSBzeXN0ZW0uCj4KPiBDYzogc3RhYmxlQHZn
ZXIua2VybmVsLm9yZwo+IEZpeGVzOiA5MzA0NTcwNTdhYmUgKCJrZXJuZWwva2V4ZWNfZmlsZS5j
OiBzcGxpdCB1cCBfX2tleGVjX2xvYWRfcHVyYWdvcnkiKQo+IFNpZ25lZC1vZmYtYnk6IFJpY2Fy
ZG8gUmliYWxkYSA8cmliYWxkYUBjaHJvbWl1bS5vcmc+CgpIaSBSaWNhcmRvLApUaGFua3MgZm9y
IHRoZSBzZXJpZXMuICBEb2VzIHRoaXMgcGF0Y2ggNC80IG5lZWQgYSBuZXcgb25saW5lIGNvbW1p
dApkZXNjcmlwdGlvbj8gSXQncyBub3QgYWRkaW5nIGEgbGlua2VyIHNjcmlwdCAobWF5YmUgYW4g
ZWFybGllciB2ZXJzaW9uCndhcykuCgo+IC0tLQo+ICBhcmNoL3Jpc2N2L3B1cmdhdG9yeS9NYWtl
ZmlsZSB8IDUgKysrKysKPiAgMSBmaWxlIGNoYW5nZWQsIDUgaW5zZXJ0aW9ucygrKQo+Cj4gZGlm
ZiAtLWdpdCBhL2FyY2gvcmlzY3YvcHVyZ2F0b3J5L01ha2VmaWxlIGIvYXJjaC9yaXNjdi9wdXJn
YXRvcnkvTWFrZWZpbGUKPiBpbmRleCA1NzMwNzk3YTZiNDAuLmNmM2E0NDEyMWE5MCAxMDA2NDQK
PiAtLS0gYS9hcmNoL3Jpc2N2L3B1cmdhdG9yeS9NYWtlZmlsZQo+ICsrKyBiL2FyY2gvcmlzY3Yv
cHVyZ2F0b3J5L01ha2VmaWxlCj4gQEAgLTM1LDYgKzM1LDExIEBAIENGTEFHU19zaGEyNTYubyA6
PSAtRF9fRElTQUJMRV9FWFBPUlRTCj4gIENGTEFHU19zdHJpbmcubyA6PSAtRF9fRElTQUJMRV9F
WFBPUlRTCj4gIENGTEFHU19jdHlwZS5vIDo9IC1EX19ESVNBQkxFX0VYUE9SVFMKPgo+ICsjIFdo
ZW4gcHJvZmlsZSBvcHRpbWl6YXRpb24gaXMgZW5hYmxlZCwgbGx2bSBlbWl0cyB0d28gZGlmZmVy
ZW50IG92ZXJsYXBwaW5nCj4gKyMgdGV4dCBzZWN0aW9ucywgd2hpY2ggaXMgbm90IHN1cHBvcnRl
ZCBieSBrZXhlYy4gUmVtb3ZlIHByb2ZpbGUgb3B0aW1pemF0aW9uCj4gKyMgZmxhZ3MuCj4gK0tC
VUlMRF9DRkxBR1MgOj0gJChmaWx0ZXItb3V0IC1mcHJvZmlsZS1zYW1wbGUtdXNlPSUgLWZwcm9m
aWxlLXVzZT0lLCQoS0JVSUxEX0NGTEFHUykpCj4gKwo+ICAjIFdoZW4gbGlua2luZyBwdXJnYXRv
cnkucm8gd2l0aCAtciB1bnJlc29sdmVkIHN5bWJvbHMgYXJlIG5vdCBjaGVja2VkLAo+ICAjIGFs
c28gbGluayBhIHB1cmdhdG9yeS5jaGsgYmluYXJ5IHdpdGhvdXQgLXIgdG8gY2hlY2sgZm9yIHVu
cmVzb2x2ZWQgc3ltYm9scy4KPiAgUFVSR0FUT1JZX0xERkxBR1MgOj0gLWUgcHVyZ2F0b3J5X3N0
YXJ0IC16IG5vZGVmYXVsdGxpYgo+Cj4gLS0KPiAyLjQwLjEuNDk1LmdjODE2ZTA5YjUzZC1nb29n
Cj4KCgotLSAKVGhhbmtzLAp+TmljayBEZXNhdWxuaWVycwoKX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX18Ka2V4ZWMgbWFpbGluZyBsaXN0CmtleGVjQGxpc3Rz
LmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5m
by9rZXhlYwo=
