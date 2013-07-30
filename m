Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Message-ID: <51F832C9.9000900@wwwdotorg.org>
Date: Tue, 30 Jul 2013 15:40:25 -0600
From: Stephen Warren <swarren@wwwdotorg.org>
MIME-Version: 1.0
Subject: Re: [PATCH] ARM: kexec: validate CPU hotplug support
References: <1373582931-11956-1-git-send-email-swarren@wwwdotorg.org>
 <51E958CC.5070906@wwwdotorg.org>
In-Reply-To: <51E958CC.5070906@wwwdotorg.org>
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
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: Russell King <linux@arm.linux.org.uk>
Cc: Stephen Warren <swarren@nvidia.com>, kexec@lists.infradead.org, Will Deacon <will.deacon@arm.com>, linux-kernel@vger.kernel.org, Simon Horman <horms@verge.net.au>, ebiederm@xmission.com, linux-arm-kernel@lists.infradead.org

On 07/19/2013 09:18 AM, Stephen Warren wrote:
> On 07/11/2013 04:48 PM, Stephen Warren wrote:
>> From: Stephen Warren <swarren@nvidia.com>
>>
>> Architectures should fully validate whether kexec is possible as part of
>> machine_kexec_prepare(), so that user-space's kexec_load() operation can
>> report any problems. Performing validation in machine_kexec() itself is
>> too late, since it is not allowed to return.
>>
>> Prior to this patch, ARM's machine_kexec() was testing after-the-fact
>> whether machine_kexec_prepare() was able to disable all but one CPU.
>> Instead, modify machine_kexec_prepare() to validate all conditions
>> necessary for machine_kexec_prepare()'s to succeed. BUG if the validation
>> succeeded, yet disabling the CPUs didn't actually work.
> 
> Russell, does this look good to put into the ARM patch tracker?

I put this in the patch tracker since I assume that no response means no
objection.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
