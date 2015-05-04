Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1YpHZd-0007wg-DW
 for kexec@lists.infradead.org; Mon, 04 May 2015 14:42:22 +0000
Message-ID: <5547852F.8030309@redhat.com>
Date: Mon, 04 May 2015 20:11:51 +0530
From: Pratyush Anand <panand@redhat.com>
MIME-Version: 1.0
Subject: Re: [PATCH RFC 0/3] arm64: disable/enable d-cache support for
References: <cover.1430742915.git.panand@redhat.com>
In-Reply-To: <cover.1430742915.git.panand@redhat.com>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: geoff@infradead.org
Cc: takahiro.akashi@linaro.org, kexec@lists.infradead.org



On Monday 04 May 2015 06:32 PM, Pratyush Anand wrote:
> These patches add support for enable/disable d cache support. It reduces
> time for sha verification from more than 2 min to 3-4 sec on my
> platform.
> There are some of the observation which I am unable to explain.
> * It takes around 18 sec when I boot a kexec kernel and around 3-4 sec
> * when I boot a crash kernel. In case of kexec kernel start of 1st
> * segment is at 0000004000280000 and, end of last segment is at
> * 00000040029c0000. In case of crash kernel start of 1st segment is at
> * 00000041b9080000 and, end of last segment is at 00000041f9000000.

There is one more observation which is not explainable :(
While executing a secondary kernel using kexec -e, if sha256_process() 
function is aligned at offset 256, it takes 18 sec else it takes double 
ie 36 sec.

# objdump -d purgatory/purgatory.ro | grep sha256_process
0000000000001300 <sha256_process>:

-> takes 18 sec

If because of some changes in code, this function shifts a bit
# objdump -d purgatory/purgatory.ro | grep sha256_process
0000000000001310 <sha256_process>:

-> takes 36 sec.

So,  "__attribute__ ((aligned (256))) void sha256_process( 
sha256_context *ctx, const uint8_t data[64] )" guarantees constant 
execution time, but how can this be justified?

~Pratyush


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
