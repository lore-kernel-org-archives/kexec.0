Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Subject: Re: [PATCH] arm64: Set -fno-PIC along with -mcmodel=large
References: <87608dprce.fsf@coreos.com>
From: Geoff Levand <geoff@infradead.org>
Message-ID: <b6fd5727-9199-1350-c175-8f9a780a095f@infradead.org>
Date: Fri, 2 Feb 2018 15:48:31 -0800
MIME-Version: 1.0
In-Reply-To: <87608dprce.fsf@coreos.com>
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
To: David Michael <david.michael@coreos.com>, horms@verge.net.au
Cc: kexec@lists.infradead.org

Hi,

On 01/07/2018 08:26 AM, David Michael wrote:
> As seen in GCC's gcc/config/aarch64/aarch64.c, -fPIC with large
> code model is unsupported.  This fixes the "sorry, unimplemented"
> errors when building with compilers defaulting to -fPIC.
> ---
> 
> purgatory/arch/arm64/entry.S:1:0: sorry, unimplemented: code model 'large' with -fPIC
> 
> This change fixes it.  Can something like this be applied?

This change seems reasonable considering large model + PIC is unsupported.

Reviewed by: Geoff Levand <geoff@infradead.org>

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
