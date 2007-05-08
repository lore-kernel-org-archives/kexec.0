Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Subject: Re: [patch 5/5] kexec fix ppc64 device-tree mem node
From: David Woodhouse <dwmw2@infradead.org>
In-Reply-To: <20070508063539.GG28460@in.ibm.com>
References: <20070507235727.631477448@am.sony.com> >
	<463FBE38.5090901@am.sony.com>  <20070508063539.GG28460@in.ibm.com>
Date: Tue, 08 May 2007 09:20:59 +0100
Message-Id: <1178612459.2824.14.camel@pmac.infradead.org>
Mime-Version: 1.0
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org+dwmw2=infradead.org@lists.infradead.org
To: mohan@in.ibm.com
Cc: kexec@lists.infradead.org, Geoff Levand <geoffrey.levand@am.sony.com>

On Tue, 2007-05-08 at 12:05 +0530, Mohan Kumar M wrote:
> On Mon, May 07, 2007 at 05:03:04PM -0700, Geoff Levand wrote:
> > Change the ppc64 device-tree memory node name spec to match the allowable names
> > specified in the booting-without-of document.
> >
> Hi,
> 
> Which part of booting-without-of-document you are refering to use
> "memory" instead of "memory@"/"memory@0" node?

About line 449:

'The kernel powerpc generic code does not make any formal use of the
unit address (though some board support code may do) so the only real
requirement here for the unit address is to ensure uniqueness of
the node unit name at a given level of the tree. Nodes with no notion
of address and no possible sibling of the same name (like /memory or
/cpus) may omit the unit address in the context of this specification,
or use the "@0" default unit address. The unit name is used to define
a node "full path", which is the concatenation of all parent node
unit names separated with "/".'

-- 
dwmw2


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
