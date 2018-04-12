Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Subject: Re: [PATCH] arm64: Set -fno-PIC along with -mcmodel=large
From: Geoff Levand <geoff@infradead.org>
References: <87608dprce.fsf@coreos.com>
 <b6fd5727-9199-1350-c175-8f9a780a095f@infradead.org>
Message-ID: <bd88df09-e87b-4820-b066-bd6ba90f3c6a@infradead.org>
Date: Thu, 12 Apr 2018 16:37:25 -0700
MIME-Version: 1.0
In-Reply-To: <b6fd5727-9199-1350-c175-8f9a780a095f@infradead.org>
Content-Language: en-US
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
To: horms@verge.net.au
Cc: David Michael <david.michael@coreos.com>, kexec@lists.infradead.org

Hi Simon,

On 02/02/2018 03:48 PM, Geoff Levand wrote:
> Hi,
> 
> On 01/07/2018 08:26 AM, David Michael wrote:
>> As seen in GCC's gcc/config/aarch64/aarch64.c, -fPIC with large
>> code model is unsupported.  This fixes the "sorry, unimplemented"
>> errors when building with compilers defaulting to -fPIC.
>> ---
>>
>> purgatory/arch/arm64/entry.S:1:0: sorry, unimplemented: code model 'large' with -fPIC
>>
>> This change fixes it.  Can something like this be applied?
> 
> This change seems reasonable considering large model + PIC is unsupported.
> 
> Reviewed by: Geoff Levand <geoff@infradead.org> 

Could you please merged this fix so arm64 builds work OK on Gentoo
and Gentoo derivatives.

Thanks.

-Geoff


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
