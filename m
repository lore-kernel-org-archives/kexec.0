Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Date: Mon, 2 Nov 2015 14:56:40 +0530
From: Pratyush Anand <panand@redhat.com>
Subject: Re: [PATCH 08/16] arm64/kexec: Add core kexec support
Message-ID: <20151102092640.GA25166@dhcppc13.redhat.com>
References: <cover.1445297709.git.geoff@infradead.org>
 <a1c2a702f127d9dade1f9af8ab13decb2ef1c0da.1445297709.git.geoff@infradead.org>
 <56339ACD.7010506@arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <56339ACD.7010506@arm.com>
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
To: James Morse <james.morse@arm.com>
Cc: Mark Rutland <mark.rutland@arm.com>, AKASHI@infradead.org, Takahiro <takahiro.akashi@linaro.org>, Geoff Levand <geoff@infradead.org>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, marc.zyngier@arm.com, linux-arm-kernel@lists.infradead.org, Dave Young <dyoung@redhat.com>, kexec@lists.infradead.org, christoffer.dall@linaro.org

Hi James,

On 30/10/2015:04:29:01 PM, James Morse wrote:
> 
> >From 'kexec -e' to the first messages from the new kernel takes ~1 minute
> on Juno, Did you see a similar delay? Or should I go looking for what I've
> configured wrong!?

I did had similar issues with mustang, where it was taking more than 2 min.

Can you please try with my kexec-tools repo [1] where I have patches to enable
D-cache for sha verification. Your feedback might help to upstream these patches.

Thanks
~Pratyush

[1] https://github.com/pratyushanand/kexec-tools.git : master

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
