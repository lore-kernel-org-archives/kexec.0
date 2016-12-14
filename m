Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Date: Wed, 14 Dec 2016 13:44:57 +0000
From: Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH 1/2] arm64: Add enable/disable d-cache support for
 purgatory
Message-ID: <20161214134457.GJ17982@leverpostej>
References: <cover.1479788404.git.panand@redhat.com>
 <7a4866b928c0905ec1074dce1bfc7984c968a58a.1479788404.git.panand@redhat.com>
 <5838834D.90205@arm.com>
 <d8f354da-1e61-feaf-f76a-18e90361e98b@redhat.com>
 <9a79b666-7990-2a23-2d74-52b3317ce272@redhat.com>
 <58512A01.70101@arm.com> <20161214113701.GE17982@leverpostej>
 <3a6ac655-bfa6-0d90-6351-731ce36e99eb@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <3a6ac655-bfa6-0d90-6351-731ce36e99eb@redhat.com>
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
To: Pratyush Anand <panand@redhat.com>
Cc: geoff@infradead.org, kexec@lists.infradead.org, Dave Young <dyoung@redhat.com>, James Morse <james.morse@arm.com>, linux-arm-kernel@lists.infradead.org

Hi,

On Wed, Dec 14, 2016 at 05:51:05PM +0530, Pratyush Anand wrote:
> 
> On Wednesday 14 December 2016 05:07 PM, Mark Rutland wrote:
> >I see in an earlier message that the need for sha256 was being discussed
> >in another thread. Do either of you happen to have a pointer to that.
> 
> patch 0/2 of this series.

AFAICT, that just says the the existing sha256 check is slow, not *why*
a sha256 check of some description is necessary. I'm still at a loss as
to why it is considered necessary, rather than being a debugging aid or
sanity check.

> >To me, it seems like it doesn't come with much benefit for the kdump
> >case given that's best-effort anyway, and as above the verification code
> >could have been be corrupted. In the non-kdump case it's not strictly
> >necessary and seems like a debugging aid rather than a necessary piece
> >of functionality -- if that's the case, a 20 second delay isn't the end
> >of the world...
> 
> Even for the non-kdump ie `kexec -l` case we do not have a
> functionality to bypass sha verification in kexec-tools. --lite
> option with the kexec-tools was discouraged and not accepted.

Ok. Do you have a pointer to the thread regarding that, for context?

> So,it is 20s for both `kexec -l` and `kexec -p`.

Well, unless we can have a --{no-,}sha-check, and make the default NO
for arm64.

> Also other arch like x86_64 takes negligible time in sha verification.

That's certainly an argument for not changing the other architectures,
but given it's slow for arm64, we could have a different default...

Thanks,
Mark.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
