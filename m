Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from mail-vx0-f177.google.com ([209.85.220.177])
	by canuck.infradead.org with esmtps (Exim 4.72 #1 (Red Hat Linux))
	id 1PxKGS-0004XE-OZ
	for kexec@lists.infradead.org; Wed, 09 Mar 2011 14:21:25 +0000
Received: by vxd2 with SMTP id 2so510815vxd.36
	for <kexec@lists.infradead.org>; Wed, 09 Mar 2011 06:21:23 -0800 (PST)
Date: Wed, 9 Mar 2011 22:21:08 +0800
From: =?utf-8?Q?Am=C3=A9rico?= Wang <xiyou.wangcong@gmail.com>
Subject: Re: [PATCH 1/2] kdump: Allow shrinking of kdump region to be
	overridden
Message-ID: <20110309142108.GD16951@cr0.redhat.com>
References: <20100825002258.GD28360@kryten> <m139u37cii.fsf@fess.ebiederm.org>
	<4D771EE6.5050404@linux.vnet.ibm.com>
	<20110309122046.GC16951@cr0.redhat.com>
	<20110309234657.264d3080@kryten>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20110309234657.264d3080@kryten>
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
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: Anton Blanchard <anton@samba.org>
Cc: Mahesh Jagannath Salgaonkar <mahesh@linux.vnet.ibm.com>, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org, "Eric W. Biederman" <ebiederm@xmission.com>, =?utf-8?Q?Am=C3=A9rico?= Wang <xiyou.wangcong@gmail.com>, akpm@linux-foundation.org

On Wed, Mar 09, 2011 at 11:46:57PM +1100, Anton Blanchard wrote:
>
>Hi,
>
>> The crashkernel region is specified via kernel cmdline, so why
>> not just drop a failure when it overlaps with RMO region?
>> Am I missing something?
>
>Unfortunately a ppc64 kernel requires a chunk of RMO memory. We would
>need the ability to specify multiple crashkernel regions - about 32MB
>in the RMO and the rest can be anywhere. That sounds pretty fragile for
>a user to configure successfully on the cmdline.
>
>Thats why the ppc64 crashkernel region begins mid way through the RMO
>region. It means both kernels get a chunk of RMO and we only have to
>deal with one crashkernel reservation in all the tools and
>documentation.
>

So, when I specify 128M in cmdline, 32M of them are RMO, and the
rest 96M are normal memory? And when I want to free all of them,
actually the 32M RMO will never be freed?


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
