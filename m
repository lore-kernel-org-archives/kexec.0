From: Huang Shijie <shijie@os.amperecomputing.com>
Date: Thu, 17 Feb 2022 10:29:25 +0000
Subject: [PATCH] arm64: crash_core: Export MODULES, VMALLOC, and VMEMMAP
 ranges
In-Reply-To: <Yg4dDZGEyRzWcGH1@hsj>
References: <20220209092642.9181-1-shijie@os.amperecomputing.com>
 <20220215164423.GB8458@willie-the-truck> <YgzD0ZfZF34u6whJ@hsj>
 <20220216124026.GB9949@willie-the-truck> <Yg4dDZGEyRzWcGH1@hsj>
Message-ID: <Yg4jhWnfYIGYBLs/@hsj>
List-Id: <kexec.lists.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: kexec@lists.infradead.org

On Thu, Feb 17, 2022 at 10:02:03AM +0000, Huang Shijie wrote:
> > Thanks for digging up all of the kernel memory map changes and taking the
> > time to explain the macros. However, all I'm really after is something in
> > the commit message of the patch which explains what is broken without this
> This kernel patch does not break anything.
I mean this kernel patch is not a bugfix, it is just make the ARM64 ecosystem
(including the Crash) a little better..

The Crash can just parse out the MODULES/VMALLOC/VMALLOC ranges from the vmcore file,
no need to calculate them in a very _hard_ way. 

Thanks
Huang Shijie

