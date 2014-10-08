Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-ig0-f172.google.com ([209.85.213.172])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1Xbnv5-0007v5-SM
 for kexec@lists.infradead.org; Wed, 08 Oct 2014 09:52:32 +0000
Received: by mail-ig0-f172.google.com with SMTP id r2so6676108igi.17
 for <kexec@lists.infradead.org>; Wed, 08 Oct 2014 02:52:09 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1412712462.32313.127.camel@smoke>
References: <cover.1411604443.git.geoff@infradead.org>
 <20141007180954.GH27464@redhat.com>
 <1412712462.32313.127.camel@smoke>
Date: Wed, 8 Oct 2014 10:52:09 +0100
Message-ID: <CAF7UmSx-jS42q9QR_r5VsUUpq5-ujR_7m5ssUbw3t1tE20ZpdA@mail.gmail.com>
Subject: Re: [PATCH 0/7] arm64 kexec kernel patches V3
From: Leif Lindholm <leif.lindholm@linaro.org>
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
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Geoff Levand <geoff@infradead.org>
Cc: Marc Zyngier <marc.zyngier@arm.com>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Christoffer Dall <christoffer.dall@linaro.org>, Vivek Goyal <vgoyal@redhat.com>, kexec@lists.infradead.org, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On 7 October 2014 21:07, Geoff Levand <geoff@infradead.org> wrote:
> You need to use a UEFI kernel loader.

No such thing exists.
The "built-in Linux loader" is a u-boot emulator (try it, it will work
with a uImage on v7) added for early development purposes and
unfortunately released in the wild.
It will very shortly disappear from Linaro UEFI builds.

/
    Leif

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
