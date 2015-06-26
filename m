Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1Z8Ivu-0001gS-ON
 for kexec@lists.infradead.org; Fri, 26 Jun 2015 01:59:59 +0000
Date: Fri, 26 Jun 2015 09:59:31 +0800
From: Dave Young <dyoung@redhat.com>
Subject: Re: kexec_load(2) bypasses signature verification
Message-ID: <20150626015931.GB12695@dhcp-128-60.nay.redhat.com>
References: <87y4jjglvu.fsf@x220.int.ebiederm.org>
 <20150617014737.GB30214@redhat.com>
 <20150618011629.GA8718@dhcp-128-32.nay.redhat.com>
 <20150618020209.GA8390@dhcp-128-32.nay.redhat.com>
 <20150618133044.GA1040@redhat.com>
 <20150619062140.GH4636@dhcp-128-32.nay.redhat.com>
 <20150619081816.GK4636@dhcp-128-32.nay.redhat.com>
 <20150619130933.GB13714@redhat.com>
 <20150625084818.GB20085@dhcp-128-31.nay.redhat.com>
 <20150625155920.GA28863@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20150625155920.GA28863@redhat.com>
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
Cc: Josh Boyer <jwboyer@fedoraproject.org>, Theodore Ts'o <tytso@mit.edu>, kexec <kexec@lists.infradead.org>, Petr Tesarik <ptesarik@suse.cz>, "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>, David Howells <dhowells@redhat.com>, "Eric W. Biederman" <ebiederm@xmission.com>

On 06/25/15 at 11:59am, Vivek Goyal wrote:
> On Thu, Jun 25, 2015 at 04:48:18PM +0800, Dave Young wrote:
> > On 06/19/15 at 09:09am, Vivek Goyal wrote:
> > > On Fri, Jun 19, 2015 at 04:18:16PM +0800, Dave Young wrote:
> > > > > > If we want to disable unsigned kernel loading at compile time, then we
> > > > > > really need to work on decoupling CONFIG_KEXEC and CONFIG_FILE_KEXEC.
> > > > > > Introducing another config option is not the way forward, IMHO.
> > > > > 
> > > > > Yes, let's do it in this way since everyone is fine with it.
> > > > 
> > > > I will work on a patch if nobody else have interest or no time on it.
> > > 
> > > Thanks Dave. Will be good if you can get this done.
> > 
> > Vivek, I worked out some draft patches here:
> > https://github.com/daveyoung/linux/commits/kexec-syscall-cleanup
> > 
> > Basiclly I split kexec_file first, then add CONFIG_KEXEC_CORE kconfig option
> > then split kexec_load code from general code.
> > 
> > There's a lot of #ifdef CONFIG_KEXEC in kernel source, because CONFIG_KEXEC
> > can be disabled so I changed all kernel general and x86 #ifdef to use
> > CONFIG_KEXEC_CORE if necessary. For other arches dependent code with #ifdef
> > I did not change anything other than the new Kconfig option. It will works
> > because only x86 support KEXEC_FILE.
> > 
> > Please take a look if you have time, if this is not what you want please let
> > me know.
> > 
> > I will have no time this week, only did building test, will do more test next
> > week, if everything is ok I can send out the patches to list for review.
> 
> Hi Dave,
> 
> I have put few comments in github. Please have a look. Once you have
> another version of patches, I will have another look.

Vivek, thanks a lot. Will have a look.

Dave

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
