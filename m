Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1XMBNK-0001xt-EW
 for kexec@lists.infradead.org; Tue, 26 Aug 2014 07:41:06 +0000
Date: Tue, 26 Aug 2014 15:41:43 +0800
From: Dave Young <dyoung@redhat.com>
Subject: Re: [PATCH 0/5] kexec: minor fixups and enhancements
Message-ID: <20140826074143.GG11693@darkstar.nay.redhat.com>
References: <cover.1408731991.git.geoff@infradead.org>
 <20140825165916.GC14379@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20140825165916.GC14379@redhat.com>
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
To: Vivek Goyal <vgoyal@redhat.com>
Cc: Geoff Levand <geoff@infradead.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, Eric Biederman <ebiederm@xmission.com>, Andrew Morton <akpm@linux-foundation.org>, linuxppc-dev@lists.ozlabs.org

On 08/25/14 at 12:59pm, Vivek Goyal wrote:
> On Fri, Aug 22, 2014 at 06:39:47PM +0000, Geoff Levand wrote:
> > Hi,
> > 
> > Here are a few minor fixups and enhancements for kexec support. 
> > 
> > Patch 3 and 4 that add preprocessor macros for the kimage list flags are
> > ones that I use in the arm64 kexec support I am working on, so it would
> > be nice for those to go in.
> > 
> > Please consider.
> 
> Hi Geoff,
> 
> Does arm64 has secureboot? If yes, then it might make sense to
> enable the new syscall kexec_file_load() on arm64 instead of trying
> to make old syscall work first.

It will save efforts for efi support as well, for the in-kernel loader we do not
necessary to save the efi physical addresses or runtime ranges to sysfs and
passing them to 2nd kernel, we can just copy them in kernel.

Thanks
Dave

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
