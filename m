Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from [2a01:111:f400:7c09::23]
 (helo=na01-bl2-obe.outbound.protection.outlook.com)
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1V7pIE-0001zG-Jf
 for kexec@lists.infradead.org; Fri, 09 Aug 2013 16:12:02 +0000
From: Matthew Garrett <matthew.garrett@nebula.com>
Subject: Re: [PATCH] kexec: Disable at runtime if the kernel enforces module
 signing
Date: Fri, 9 Aug 2013 16:11:09 +0000
Message-ID: <1376064648.15604.5.camel@x230>
References: <1376033797-24970-1-git-send-email-matthew.garrett@nebula.com>
 <20130809110200.GA9631@redhat.com> <1376060830.2021.12.camel@x230>
 <20130809153519.GI12688@redhat.com>
In-Reply-To: <20130809153519.GI12688@redhat.com>
Content-Language: en-US
Content-ID: <1A1E39FF1A57E04996AF4100FB8EEEBF@namprd05.prod.outlook.com>
MIME-Version: 1.0
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
To: Vivek Goyal <vgoyal@redhat.com>
Cc: "kexec@lists.infradead.org" <kexec@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On Fri, 2013-08-09 at 11:35 -0400, Vivek Goyal wrote:

> Also what about all the other patches you had for secureboot where you
> closed down all the paths where root could write to kernel memory. So
> if you want to protect sig_enforce boolean, then you need to close down
> all these paths irrespective of secureboot?

Fair point. The bar is slightly higher there, but yes, it seems
reasonable to say that enforcing module signing (and, come to think of
it, modules_disabled) should also lock down the other obvious mechanisms
for root to get code into the kernel.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
