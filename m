Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Message-ID: <56658696.6070103@arm.com>
Date: Mon, 07 Dec 2015 13:16:06 +0000
From: James Morse <james.morse@arm.com>
MIME-Version: 1.0
Subject: Re: [PATCH] kexec: Add --lite option
References: <1445469125.30908.105.camel@infradead.org>
 <20151022031718.GB11227@dhcp-129-115.nay.redhat.com>
 <20151022125012.GB20847@redhat.com>
 <1445540891.30908.144.camel@infradead.org>
 <1446703011.12676.83.camel@freescale.com>
 <20151207114547.GE16406@dhcppc13.redhat.com>
 <20151207114839.GF16406@dhcppc13.redhat.com>
In-Reply-To: <20151207114839.GF16406@dhcppc13.redhat.com>
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
Cc: Geoff Levand <geoff@infradead.org>, kexec@lists.infradead.org, Simon Horman <horms@verge.net.au>, Vivek Goyal <vgoyal@redhat.com>, Petitboot@lists.ozlabs.org, Scott Wood <scottwood@freescale.com>, Dave Young <dyoung@redhat.com>, linux-arm-kernel@lists.infradead.org

Hi Pratyush,

On 07/12/15 11:48, Pratyush Anand wrote:
>> 1) When we execute kexec() system call in first kernel, at that time it
>> calculates sha256 on all the binaries [1]. It take almost un-noticeable time
>> (less than a sec) there.
>>
>> 2) When purgatory is executed then it re-calculates sha256 using same routines
>> [2] on same binary data as that of case (1). But, now it takes 10-20 sec
>> (depending of size of binaries)?
>>
>> Why did not it take same time with O2 + D-cache enabled? I think, we should be
>> able to achieve same time in second case as well. What is missing?

I haven't benchmarked this, but:

util_lib/sha256.c contains calls out to memcpy().
In your case 1, this will use the glibc version. In case 2, it will use
the version implemented in purgatory/string.c, which is a byte-by-byte copy.


Thanks,

James

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
