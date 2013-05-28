Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by merlin.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1UhLCo-0007WB-IA
 for kexec@lists.infradead.org; Tue, 28 May 2013 14:48:55 +0000
Date: Tue, 28 May 2013 10:48:21 -0400
From: Vivek Goyal <vgoyal@redhat.com>
Subject: Re: [PATCH 4/4] kexec-tools: Add cgroup_disable=memory to crash
 kernel parameters
Message-ID: <20130528144821.GF7088@redhat.com>
References: <1369213056-77661-1-git-send-email-trenn@suse.de>
 <1369213056-77661-5-git-send-email-trenn@suse.de>
 <20130526132020.GE11134@verge.net.au>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20130526132020.GE11134@verge.net.au>
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
To: Simon Horman <horms@verge.net.au>
Cc: yinghai@kernel.org, kexec@lists.infradead.org, Thomas Renninger <trenn@suse.de>, ebiederm@xmission.com

On Sun, May 26, 2013 at 10:20:21PM +0900, Simon Horman wrote:
> On Wed, May 22, 2013 at 10:57:36AM +0200, Thomas Renninger wrote:
> > cgroup memory subsystem pre-allocates quite some memory at boot up.
> > Example dmesg:
> > allocated 469762048 bytes of page_cgroup
> > please try 'cgroup_disable=memory' option if you don't want memory cgroups
> > 
> > Due to maxcpu=1 it is by far not that much than in a productive kernel.
> > It still seem to be around 4M statically as no Numa overhead exists with
> > only one active CPU. It is still worth to disable cgroup memory
> > pre-allocating in crash kernel environment.
> > 
> > Signed-off-by: Thomas Renninger <trenn@suse.de>
> > Signed-off-by: Thomas Renninger <Thomas Renninger" trenn@suse.de>
> 
> I'm not really sure this kind of logic should be hard-coded into
> kexec-tools. --append should allow callers of kexec to add this
> option if it is appropriate.

Agreed. cgroup_disable=memory is better not hard coded here. In F19
default config we have cgroup_disable=memory specified which is passed
to kexec-tools using --append option.

Thanks
Vivek

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
