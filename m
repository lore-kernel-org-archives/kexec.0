Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from tyo201.gate.nec.co.jp ([202.32.8.193])
	by bombadil.infradead.org with esmtps (Exim 4.69 #1 (Red Hat Linux))
	id 1LvoiO-0004rW-JM
	for kexec@lists.infradead.org; Mon, 20 Apr 2009 08:19:03 +0000
Message-ID: <49EC2AFF.1050107@mxs.nes.nec.co.jp>
Date: Mon, 20 Apr 2009 16:57:51 +0900
From: "Ken'ichi Ohmichi" <oomichi@mxs.nes.nec.co.jp>
MIME-Version: 1.0
Subject: Re: makedumpfile question / request
References: <123826343.4880961239996278674.JavaMail.root@zmail05.collab.prod.int.phx2.redhat.com>
In-Reply-To: <123826343.4880961239996278674.JavaMail.root@zmail05.collab.prod.int.phx2.redhat.com>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Dave Anderson <anderson@redhat.com>
Cc: kexec-ml <kexec@lists.infradead.org>, "Discussion list for crash utility usage,
	maintenance and development" <crash-utility@redhat.com>


Hi Dave,

Dave Anderson wrote:
> Is there a reason that makedumpfile does not fill in the utsname structure
> in the compressed dumpfile's header?  

Thank you for good point.

makedumpfile does not fill it because makedumpfile might not be able to
get kernel debug information (containing symbol system_utsname/init_uts_ns).
makedumpfile does not need kernel debug information if dump_level is 0 or 1,
and it does not read a new_utsname structure. (check_release() is not called.)


> The data structure does get read into a local new_utsname structure in the
> check_release() function, but it doesn't get saved and copied into the
> disk_dump_header in write_kdump_header().
>
> It would be helpful if that were in place as a quick ID for what the
> compressed dumpfile contains.

I feel that is worth.
How about saving new_utsname data into disk_dump_header only if dump_level
is 2 or bigger ?


Thanks
Ken'ichi Ohmichi


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
