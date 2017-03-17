Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Date: Fri, 17 Mar 2017 15:33:58 +0000
From: Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH v33 00/14] add kdump support
Message-ID: <20170317153358.GI5940@leverpostej>
References: <20170315095656.24992-1-takahiro.akashi@linaro.org>
 <1489750991.17202.40.camel@infradead.org>
 <1489759373.17202.44.camel@infradead.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1489759373.17202.44.camel@infradead.org>
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
To: David Woodhouse <dwmw2@infradead.org>
Cc: geoff@infradead.org, kexec@lists.infradead.org, will.deacon@arm.com, AKASHI Takahiro <takahiro.akashi@linaro.org>, james.morse@arm.com, catalin.marinas@arm.com, bauerman@linux.vnet.ibm.com, dyoung@redhat.com, linux-arm-kernel@lists.infradead.org

On Fri, Mar 17, 2017 at 02:02:53PM +0000, David Woodhouse wrote:
> On Fri, 2017-03-17 at 11:43 +0000, David Woodhouse wrote:
> > 
> > Is this one going to be be my fault too?
> 
> Looks like it isn't my fault. In ipi_cpu_crash_stop() we don't modify
> the online mask. Which is reasonable enough if we want to preserve its
> original contents from before the crash, but it does make that
> WARN_ON() in machine_kexec() a false positive.

I'd say it's not so much a false positive, but rather an uninformative
message.

Some warning here is completely appropriate. Even if the CPUs are
stopped in the kernel, there are a number of cases where the HW can
corrupt system state in the background.

We can certainly log a better message, e.g.
	
	bool kdump = (image == kexec_crash_image);
	bool stuck_cpus = cpus_are_stuck_in_kernel() ||
			  num_online_cpus() > 1;

	BUG_ON(stuck_cpus && !kdump);
	WARN(stuck_cpus, "Unable to offline CPUs, kdump will be unreliable.\n");

Thanks,
Mark.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
