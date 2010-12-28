Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
	by canuck.infradead.org with esmtp (Exim 4.72 #1 (Red Hat Linux))
	id 1PXN5e-0005hv-Rj
	for kexec@lists.infradead.org; Tue, 28 Dec 2010 00:06:59 +0000
Date: Tue, 28 Dec 2010 05:36:51 +0530
From: Vivek Goyal <vgoyal@redhat.com>
Subject: Re: How does kdump deal with trampoline allocation?
Message-ID: <20101228000651.GB4142@redhat.com>
References: <4D18F798.4010708@zytor.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <4D18F798.4010708@zytor.com>
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
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: Yinghai Lu <yinghai@kernel.org>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>, "Eric W. Biederman" <ebiederm@xmission.com>

On Mon, Dec 27, 2010 at 12:31:20PM -0800, H. Peter Anvin wrote:
> Hi guys,
> 
> I'm planning a major overhaul of the trampoline allocation in x86, and
> I'm trying to understand how kdump deals with it.  The trampoline has to
> be allocated in low memory (< 1 MiB) and obviously that doesn't include
> the kdump area at all.

Hi Peter,

Kdump has the concept of backup area. We backup the contents of first
640KB of physical RAM in kdump reserved area and then allow kdump kernel
to use first 640KB of memory. So any trampoline allocation can be done
in low memory area without overwritting the contents of first kernel.

Thanks
Vivek 

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
