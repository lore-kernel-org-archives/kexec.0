Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Message-ID: <1427733646.8283.1.camel@infradead.org>
Subject: Re: arm64 kexec hang
From: Geoff Levand <geoff@infradead.org>
Date: Mon, 30 Mar 2015 09:40:46 -0700
In-Reply-To: <55196AEB.2040204@redhat.com>
References: <1427477015.27739.30.camel@infradead.org>
 <5515C799.8010600@redhat.com> <551940F5.9050102@redhat.com>
 <55195FE3.5090409@redhat.com> <55196AEB.2040204@redhat.com>
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
To: Pratyush Anand <panand@redhat.com>
Cc: "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Takahiro Akashi <takahiro.akashi@linaro.org>, kexec@lists.infradead.org, Vivek Goyal <vgoyal@redhat.com>, Kyle McMartin <kmcmarti@redhat.com>

Hi Pratyush,

On Mon, 2015-03-30 at 20:55 +0530, Pratyush Anand wrote:
> So, this was it. With above changes kexec reboot works fine with 
> purgatory too.

OK, great, thanks for working through it.

> By the way, how much execution time expected for verify_sha256_digest? I 
> have not quantified, but it seems that it takes minutes to execute that.

The digest takes a long time, but it doesn't take minutes on
the fast models.  Maybe you could put some print statements
in the code to see if it is the digest that takes the time,
or something else.  It could be a driver or something waiting
for an event, etc.

-Geoff



_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
