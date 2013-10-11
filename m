Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from cavan.codon.org.uk ([2a00:1098:0:80:1000:c:0:1])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1VUenM-0006D1-2S
 for kexec@lists.infradead.org; Fri, 11 Oct 2013 15:38:28 +0000
Date: Fri, 11 Oct 2013 16:37:27 +0100
From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: kexec: Clearing registers just before jumping into purgatory
Message-ID: <20131011153727.GA30181@srcf.ucam.org>
References: <20131011092837.GZ3626@debian70-amd64.local.net-space.pl>
 <877gdkce6s.fsf@tw-ebiederman.twitter.com>
 <20131011110455.GA3626@debian70-amd64.local.net-space.pl>
 <20131011125206.GA2772@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20131011125206.GA2772@redhat.com>
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
Cc: keir@xen.org, keescook@chromium.org, Daniel Kiper <daniel.kiper@oracle.com>, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, xen-devel@lists.xen.org, hbabu@us.ibm.com, ebiederm@xmission.com, jbeulich@suse.com, hpa@linux.intel.com, david.vrabel@citrix.com

On Fri, Oct 11, 2013 at 08:52:06AM -0400, Vivek Goyal wrote:
> On Fri, Oct 11, 2013 at 01:04:55PM +0200, Daniel Kiper wrote:
> 
> [..]
> > > In theory you can swap between to kernels with the preserve_context
> > > case.  Technically I like the ability but I don't know that it has ever
> > > achieved much uptake.
> > 
> > I think that this is nice idea too. However, I have not seen its usage in real.
> > Even once there was an idea to remove that stuff from Linux Kernel.
> 
> I have not seen anybody using it. I don't even know if it works or not.

It works. I'm using it.

-- 
Matthew Garrett | mjg59@srcf.ucam.org

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
