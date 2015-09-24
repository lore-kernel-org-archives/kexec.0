Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Message-ID: <1443121464.3637.3.camel@infradead.org>
Subject: Re: [PATCH 2/6] arm64: Convert hcalls to use HVC immediate value
From: Geoff Levand <geoff@infradead.org>
Date: Thu, 24 Sep 2015 12:04:24 -0700
In-Reply-To: <CAOZdJXUNhGk59vEnAhXBUun2ieiuUfYH=GKmeB4-wK=azv5HBw@mail.gmail.com>
References: <cover.1426793116.git.geoff@infradead.org>
 <f1d72f4782ef5185626a012872f9ebefe057c7e8.1426793116.git.geoff@infradead.org>
 <CAOZdJXUNhGk59vEnAhXBUun2ieiuUfYH=GKmeB4-wK=azv5HBw@mail.gmail.com>
Mime-Version: 1.0
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
To: Timur Tabi <timur@codeaurora.org>
Cc: Marc Zyngier <marc.zyngier@arm.com>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, kexec@lists.infradead.org, Christoffer Dall <christoffer.dall@linaro.org>

On Wed, 2015-09-23 at 14:21 -0500, Timur Tabi wrote:
> What is the status of this patch?  I see it's not in 4.2.  I ask
> because this patch might be breaking our 4.2-based kernel, and I'm
> just wondering if it's still applicable.

I have it in my linux-kexec repo, which currently based on 4.3-rc2.  I
plan to submit it again in the next week or so after testing.

-Geoff



_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
