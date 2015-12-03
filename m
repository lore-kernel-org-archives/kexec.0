Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Date: Thu, 3 Dec 2015 11:39:01 +0530
From: Pratyush Anand <panand@redhat.com>
Subject: Re: [PATCH v12 08/16] arm64/kexec: Add core kexec support
Message-ID: <20151203060901.GH14143@dhcppc13.redhat.com>
References: <cover.1448403503.git.geoff@infradead.org>
 <6ac232ad37d6b02cf2d5848b15236f26f5ac61ac.1448403503.git.geoff@infradead.org>
 <20151127131306.GE23908@dhcppc13.redhat.com>
 <1448909475.31214.27.camel@infradead.org>
 <20151201021615.GA5704@dhcppc13.redhat.com>
 <002101d12c66$ae985440$0bc8fcc0$@codeaurora.org>
 <1449096562.6139.74.camel@infradead.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1449096562.6139.74.camel@infradead.org>
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
Cc: 'Mark Rutland' <mark.rutland@arm.com>, marc.zyngier@arm.com, 'Catalin Marinas' <catalin.marinas@arm.com>, Azriel Samson <asamson@codeaurora.org>, 'Will Deacon' <will.deacon@arm.com>, 'AKASHI Takahiro' <takahiro.akashi@linaro.org>, christoffer.dall@linaro.org, 'Dave Young' <dyoung@redhat.com>, kexec@lists.infradead.org, linux-arm-kernel@lists.infradead.org

Hi Geoff,

On 02/12/2015:02:49:22 PM, Geoff Levand wrote:
> Azriel and Pratyush,
> 
> On Tue, 2015-12-01 at 11:32 -0700, Azriel Samson wrote:
> > I tested with v11 on our platform and I too needed the invalidation
> > fix.
> 
> I pushed out a kexec-v12.1 branch to my linux-kexec repo [1] with
> fixes.  Could you test it with both kexec reboot and kdump?  For
> kdump, use something like:

I tested kexec-v12.1 with mustang and it works for both kexec and kdump.

There had been few updates with Akashi, which are not there in kexec-v12.1.
Please take his updates and merge them in v13.

~Pratyush

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
