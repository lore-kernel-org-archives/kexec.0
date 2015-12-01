Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Message-ID: <565D6A88.10408@arm.com>
Date: Tue, 01 Dec 2015 09:38:16 +0000
From: Marc Zyngier <marc.zyngier@arm.com>
MIME-Version: 1.0
Subject: Re: [PATCH v12 05/16] arm64: Add back cpu_reset routines
References: <cover.1448403503.git.geoff@infradead.org>	
 <3279584774ba40f088b79f4df864d69a5b57b516.1448403503.git.geoff@infradead.org>	
 <56586679.8060403@arm.com> <1448913810.31214.61.camel@infradead.org>
In-Reply-To: <1448913810.31214.61.camel@infradead.org>
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
To: Geoff Levand <geoff@infradead.org>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>
Cc: Mark Rutland <mark.rutland@arm.com>, AKASHI Takahiro <takahiro.akashi@linaro.org>, kexec@lists.infradead.org, linux-arm-kernel@lists.infradead.org, christoffer.dall@linaro.org

On 30/11/15 20:03, Geoff Levand wrote:

Hi Geoff,

>>> +.align 5
>>
>> Why is this .align directive required?
> 
> In the original proc.S file, this was to align the cpu_reset
> routine.  It has been there since the initial commit of the
> proc.S.  I don't think this alignment is needed, but maybe
> there is some reason it is there that I am not aware of?

None that I can think of, so just drop it - we'll find out pretty
quickly if there was an actual requirement.

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
