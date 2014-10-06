Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from terminus.zytor.com ([2001:1868:205::10] helo=mail.zytor.com)
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1XbCLJ-0007sc-Ox
 for kexec@lists.infradead.org; Mon, 06 Oct 2014 17:45:06 +0000
Message-ID: <5432D4E7.3060804@zytor.com>
Date: Mon, 06 Oct 2014 10:44:07 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
MIME-Version: 1.0
Subject: Re: [PATCH 1/5] kexec: Fix make headers_check
References: <cover.1408731991.git.geoff@infradead.org>	
 <115373b6ac68ee7a305975896e1c4971e8e51d4c.1408731991.git.geoff@infradead.org>	
 <20140825172234.GD14379@redhat.com> <1409402838.21896.99.camel@x220>
In-Reply-To: <1409402838.21896.99.camel@x220>
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
To: Paul Bolle <pebolle@tiscali.nl>, Vivek Goyal <vgoyal@redhat.com>
Cc: maximilian attems <max@stro.at>, Geoff Levand <geoff@infradead.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, Eric Biederman <ebiederm@xmission.com>, Andrew Morton <akpm@linux-foundation.org>, linuxppc-dev@lists.ozlabs.org

On 08/30/2014 05:47 AM, Paul Bolle wrote:
> 
> Obviously, this can only break compiling those libraries, or other
> users. It can't break already compiled binaries. Besides I don't think
> those libraries, etc actually exist. Maximilian mentioned klibc in
> January, but I wasn't able to find a version of klibc that cared about
> this prototype. No one pointed me at a version that does (or any other
> library, etc., for that matter).
> 

... and that would be a klibc bug and we'd just fix it.

	-hpa



_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
