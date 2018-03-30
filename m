Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-wm0-x242.google.com ([2a00:1450:400c:c09::242])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1f1rRI-0003Zn-HK
 for kexec@lists.infradead.org; Fri, 30 Mar 2018 10:39:22 +0000
Received: by mail-wm0-x242.google.com with SMTP id p9so14984018wmc.3
 for <kexec@lists.infradead.org>; Fri, 30 Mar 2018 03:39:09 -0700 (PDT)
Date: Fri, 30 Mar 2018 12:39:07 +0200
From: Jiri Pirko <jiri@resnulli.us>
Subject: Re: [PATCH net-next v2 1/2] fs/crashdd: add API to collect hardware
 dump in second kernel
Message-ID: <20180330103907.GC3313@nanopsycho>
References: <cover.1521888444.git.rahul.lakkireddy@chelsio.com>
 <296ffbd47fd4f30238689e636bd2480683224227.1521888444.git.rahul.lakkireddy@chelsio.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <296ffbd47fd4f30238689e636bd2480683224227.1521888444.git.rahul.lakkireddy@chelsio.com>
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
To: Rahul Lakkireddy <rahul.lakkireddy@chelsio.com>
Cc: indranil@chelsio.com, netdev@vger.kernel.org, nirranjan@chelsio.com, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, stephen@networkplumber.org, ganeshgr@chelsio.com, viro@zeniv.linux.org.uk, linux-fsdevel@vger.kernel.org, akpm@linux-foundation.org, torvalds@linux-foundation.org, davem@davemloft.net, ebiederm@xmission.com

Sat, Mar 24, 2018 at 11:56:33AM CET, rahul.lakkireddy@chelsio.com wrote:
>Add a new module crashdd that exports the /sys/kernel/crashdd/
>directory in second kernel, containing collected hardware/firmware
>dumps.
>
>The sequence of actions done by device drivers to append their device
>specific hardware/firmware logs to /sys/kernel/crashdd/ directory are
>as follows:
>
>1. During probe (before hardware is initialized), device drivers
>register to the crashdd module (via crashdd_add_dump()), with
>callback function, along with buffer size and log name needed for
>firmware/hardware log collection.
>
>2. Crashdd creates a driver's directory under
>/sys/kernel/crashdd/<driver>. Then, it allocates the buffer with

This smells. I need to identify the exact ASIC instance that produced
the dump. To identify by driver name does not help me if I have multiple
instances of the same driver. This looks wrong to me. This looks like
a job for devlink where you have 1 devlink instance per 1 ASIC instance.

Please see:
http://patchwork.ozlabs.org/project/netdev/list/?series=36524

I bevieve that the solution in the patchset could be used for
your usecase too.


>requested size and invokes the device driver's registered callback
>function.
>
>3. Device driver collects all hardware/firmware logs into the buffer
>and returns control back to crashdd.
>
>4. Crashdd exposes the buffer as a binary file via
>/sys/kernel/crashdd/<driver>/<dump_file>.
>

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
