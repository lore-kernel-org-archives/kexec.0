Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by merlin.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1VUcCq-000867-53
 for kexec@lists.infradead.org; Fri, 11 Oct 2013 12:52:37 +0000
Date: Fri, 11 Oct 2013 08:52:06 -0400
From: Vivek Goyal <vgoyal@redhat.com>
Subject: Re: kexec: Clearing registers just before jumping into purgatory
Message-ID: <20131011125206.GA2772@redhat.com>
References: <20131011092837.GZ3626@debian70-amd64.local.net-space.pl>
 <877gdkce6s.fsf@tw-ebiederman.twitter.com>
 <20131011110455.GA3626@debian70-amd64.local.net-space.pl>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20131011110455.GA3626@debian70-amd64.local.net-space.pl>
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
To: Daniel Kiper <daniel.kiper@oracle.com>
Cc: keir@xen.org, keescook@chromium.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, xen-devel@lists.xen.org, hbabu@us.ibm.com, ebiederm@xmission.com, jbeulich@suse.com, hpa@linux.intel.com, david.vrabel@citrix.com

On Fri, Oct 11, 2013 at 01:04:55PM +0200, Daniel Kiper wrote:

[..]
> > In theory you can swap between to kernels with the preserve_context
> > case.  Technically I like the ability but I don't know that it has ever
> > achieved much uptake.
> 
> I think that this is nice idea too. However, I have not seen its usage in real.
> Even once there was an idea to remove that stuff from Linux Kernel.

I have not seen anybody using it. I don't even know if it works or not. If
nobody is using it, I will advocate removing it. It introduces extra
complexity and makes new code changes more difficult.

Thanks
Vivek

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
