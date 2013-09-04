Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from mail-bl2lp0203.outbound.protection.outlook.com
 ([207.46.163.203] helo=na01-bl2-obe.outbound.protection.outlook.com)
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1VHJRO-0007GX-9L
 for kexec@lists.infradead.org; Wed, 04 Sep 2013 20:12:39 +0000
From: Matthew Garrett <matthew.garrett@nebula.com>
Subject: Re: [PATCH V3 08/11] kexec: Disable at runtime if the kernel
 enforces module loading restrictions
Date: Wed, 4 Sep 2013 20:12:09 +0000
Message-ID: <1378325529.13193.8.camel@x230>
References: <1378252218-18798-1-git-send-email-matthew.garrett@nebula.com>
 <1378252218-18798-9-git-send-email-matthew.garrett@nebula.com>
 <20130904200959.GE8540@anatevka.fc.hp.com>
In-Reply-To: <20130904200959.GE8540@anatevka.fc.hp.com>
Content-Language: en-US
Content-ID: <72C1C6130164D64EA8A958B3BA00E179@namprd05.prod.outlook.com>
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
To: "jerry.hoemann@hp.com" <jerry.hoemann@hp.com>
Cc: "linux-efi@vger.kernel.org" <linux-efi@vger.kernel.org>, "keescook@chromium.org" <keescook@chromium.org>, kexec <kexec@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "hpa@zytor.com" <hpa@zytor.com>, "vgoyal@redhat.com" <vgoyal@redhat.com>

On Wed, 2013-09-04 at 14:09 -0600, jerry.hoemann@hp.com wrote:
> On Tue, Sep 03, 2013 at 07:50:15PM -0400, Matthew Garrett wrote:
> > kexec permits the loading and execution of arbitrary code in ring 0, which
> > is something that module signing enforcement is meant to prevent. It makes
> > sense to disable kexec in this situation.
> > 
> > Signed-off-by: Matthew Garrett <matthew.garrett@nebula.com>
> 
> 
> Matthew,
> 
> Disabling kexec will disable kdump, correct?

Yes.

> Are there plans to enable kdump on a system where secure
> boot is enabled?

Yes, Vivek Goyal (cc:ed) is working on that.

-- 
Matthew Garrett <matthew.garrett@nebula.com>
_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
