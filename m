Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Date: Wed, 8 Oct 2014 11:07:03 +0100
From: Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH 0/7] arm64 kexec kernel patches V3
Message-ID: <20141008100703.GI27216@leverpostej>
References: <cover.1411604443.git.geoff@infradead.org>
 <20141007180954.GH27464@redhat.com>
 <1412712462.32313.127.camel@smoke>
 <CAF7UmSx-jS42q9QR_r5VsUUpq5-ujR_7m5ssUbw3t1tE20ZpdA@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAF7UmSx-jS42q9QR_r5VsUUpq5-ujR_7m5ssUbw3t1tE20ZpdA@mail.gmail.com>
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
To: Leif Lindholm <leif.lindholm@linaro.org>
Cc: "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Geoff Levand <geoff@infradead.org>, Catalin Marinas <Catalin.Marinas@arm.com>, Will Deacon <Will.Deacon@arm.com>, Marc Zyngier <Marc.Zyngier@arm.com>, Christoffer Dall <christoffer.dall@linaro.org>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>, Vivek Goyal <vgoyal@redhat.com>

On Wed, Oct 08, 2014 at 10:52:09AM +0100, Leif Lindholm wrote:
> On 7 October 2014 21:07, Geoff Levand <geoff@infradead.org> wrote:
> > You need to use a UEFI kernel loader.
> 
> No such thing exists.
> The "built-in Linux loader" is a u-boot emulator (try it, it will work
> with a uImage on v7) added for early development purposes and
> unfortunately released in the wild.
> It will very shortly disappear from Linaro UEFI builds.

To further Leif's point, the "built-in Linux loader" is not in the UEFI
spec, and is therefore not a portion of UEFI. It is a crutch, and it
should not be relied upon as anything more than an aid during bringup.

Mark.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
