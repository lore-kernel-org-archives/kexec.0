Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by merlin.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1VJkkF-0006Cg-AQ
 for kexec@lists.infradead.org; Wed, 11 Sep 2013 13:46:11 +0000
Date: Wed, 11 Sep 2013 09:45:34 -0400
From: Vivek Goyal <vgoyal@redhat.com>
Subject: Re: [PATCH 15/16] bootparam: Pass acpi_rsdp pointer in bootparam
Message-ID: <20130911134534.GB15364@redhat.com>
References: <1378849471-10521-1-git-send-email-vgoyal@redhat.com>
 <1378849471-10521-16-git-send-email-vgoyal@redhat.com>
 <522FA2A8.8080703@zytor.com> <20130911114419.GB31551@x1.alien8.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20130911114419.GB31551@x1.alien8.de>
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
To: Borislav Petkov <bp@alien8.de>
Cc: matthew.garrett@nebula.com, Dave Young <dyoung@redhat.com>, d.kasatkin@samsung.com, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org, ebiederm@xmission.com, "H. Peter Anvin" <hpa@zytor.com>, akpm@linux-foundation.org, zohar@linux.vnet.ibm.com

On Wed, Sep 11, 2013 at 01:44:19PM +0200, Borislav Petkov wrote:
> On Tue, Sep 10, 2013 at 03:52:24PM -0700, H. Peter Anvin wrote:
> > Borislav Petkov has been working on a fixed mapping of UEFI memory,...
> 
> ... who will back from vacation on Monday and will be sending out a new
> RFC version.

Hi Boris,

I am looking forward to that new version. CCing Dave Young. He is also 
looking into it and going through history of patches.

Thanks
Vivek

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
