Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Message-ID: <1430931959.12082.12.camel@infradead.org>
Subject: Re: [PATCH RFC 0/3] arm64: disable/enable d-cache support for
From: Geoff Levand <geoff@infradead.org>
Date: Wed, 06 May 2015 10:05:59 -0700
In-Reply-To: <cover.1430742915.git.panand@redhat.com>
References: <cover.1430742915.git.panand@redhat.com>
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
Cc: takahiro.akashi@linaro.org, kexec@lists.infradead.org

Hi,

I don't really like the idea of doing cache operations in purgatory.
For fast reboot we have the --lite option to kexec, which will skip the
digest calculations.

Your 2 minutes seems like a long time.  Is this seen on other platforms?

-Geoff


On Mon, 2015-05-04 at 18:32 +0530, Pratyush Anand wrote:
> These patches add support for enable/disable d cache support. It reduces
> time for sha verification from more than 2 min to 3-4 sec on my
> platform. 
> There are some of the observation which I am unable to explain.
> * It takes around 18 sec when I boot a kexec kernel and around 3-4 sec
> * when I boot a crash kernel. In case of kexec kernel start of 1st
> * segment is at 0000004000280000 and, end of last segment is at
> * 00000040029c0000. In case of crash kernel start of 1st segment is at
> * 00000041b9080000 and, end of last segment is at 00000041f9000000.
> 
> Pratyush Anand (3):
>   arm64: Add enable/disable d-cache support for purgatory
>   arm64: Pass RAM boundary to purgatory
>   arm64: Enable/disable D-cache before/after sha verification
> 
>  kexec/arch/arm64/include/types.h       |  16 +++
>  kexec/arch/arm64/kexec-arm64.c         |  16 ++-
>  purgatory/arch/arm64/Makefile          |   1 +
>  purgatory/arch/arm64/cache.S           | 222 +++++++++++++++++++++++++++++++++
>  purgatory/arch/arm64/cache.h           |  42 +++++++
>  purgatory/arch/arm64/entry.S           |  10 ++
>  purgatory/arch/arm64/purgatory-arm64.c |  12 ++
>  7 files changed, 318 insertions(+), 1 deletion(-)
>  create mode 100644 kexec/arch/arm64/include/types.h
>  create mode 100644 purgatory/arch/arm64/cache.S
>  create mode 100644 purgatory/arch/arm64/cache.h
> 



_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
