Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from edison.jonmasters.org ([173.255.233.168])
 by bombadil.infradead.org with esmtps (Exim 4.87 #1 (Red Hat Linux))
 id 1cezfV-0000IK-Qz
 for kexec@lists.infradead.org; Sat, 18 Feb 2017 07:42:59 +0000
References: <52a88de81ea3c62bb2be9e222eb85805@nuclearcat.com>
From: Jon Masters <jcm@jonmasters.org>
Message-ID: <23681d9b-fec9-8ec7-3772-db5b36da9725@jonmasters.org>
Date: Sat, 18 Feb 2017 02:42:12 -0500
MIME-Version: 1.0
In-Reply-To: <52a88de81ea3c62bb2be9e222eb85805@nuclearcat.com>
Subject: Re: kexec on panic
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
To: Denys Fedoryshchenko <nuclearcat@nuclearcat.com>, linux-kernel@vger.kernel.org, kexec@lists.infradead.org

Hi Denys,

On 02/10/2017 03:14 AM, Denys Fedoryshchenko wrote:

> After years of using kexec and recent unpleasant experience with modern (supposed to be blazing fast to boot) hardware that need 5-10 minutes just to pass POST tests,
> one question came up to me:
> Is it possible anyhow to execute regular (not special "panic" one to capture crash data) kexec on panic to reduce reboot time?

Generally, you don't want to do this, because various platform hardware
might be in non-quiescent states (still doing DMA to random memory, etc.)
and other nastiness that means you don't want to do more than the minimal
amount in a kexec on panic (crash). We've seen no end of fun and games
even with just regular crash dumps while hardware is busily writing to
memory that it shouldn't be. An IOMMU helps, but isn't a cure-all.

Jon.


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
